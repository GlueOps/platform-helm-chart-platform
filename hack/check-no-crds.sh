#!/usr/bin/env bash
# Proves that NO Argo CD Application in this chart renders a CustomResourceDefinition.
#
# Platform CRDs are installed out-of-band, before Argo CD and before this chart, from the
# layer-0 bundle (GlueOps/platform-crds, applied by captain_utils). Every Application here
# must therefore disable CRD rendering in its chart (crds.enabled/installCRDs/crds.install
# values, or helm.skipCrds for charts that ship a crds/ directory). This script renders each
# Application's chart the way Argo CD would and fails if a CRD shows up anywhere.
#
# How Argo CD (3.x) renders a Helm source, mirrored here:
#   helm template <release> <chart> --namespace <destination.namespace> \
#     [--include-crds unless helm.skipCrds] --values <helm.values> --set <helm.parameters>
# Plain `directory:` sources from a git repository are cloned and their manifests scanned for
# CRDs as well; only the tenant captain repo (a placeholder URL in this chart) is skipped.
#
# Usage: hack/check-no-crds.sh            (needs helm, yq (mikefarah v4), jq, git, network)
#   CI_VALUES=<file>   values file for rendering the platform chart (default: ci/values.yaml)
#   KUBE_VERSION=x.y.z optional --kube-version passed to every helm template
#   API_VERSIONS=a/v1,b/v2  comma-separated --api-versions (default: the API groups served by
#                      the platform-crds bundle, so charts that gate CRs on
#                      .Capabilities.APIVersions render as they do on a real cluster)
#   KEEP_WORK=1        keep the work directory (printed at the end) for debugging
set -euo pipefail

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CI_VALUES="${CI_VALUES:-$CHART_DIR/ci/values.yaml}"
WORK="$(mktemp -d)"
CACHE="$WORK/cache"
mkdir -p "$CACHE"
cleanup() { if [ "${KEEP_WORK:-0}" = "1" ]; then echo "work dir kept: $WORK"; else rm -rf "$WORK"; fi; }
trap cleanup EXIT

for tool in helm yq jq git; do
  command -v "$tool" >/dev/null || { echo "::error::$tool is required"; exit 2; }
done
yq --version 2>&1 | grep -q 'mikefarah' || { echo "::error::yq must be mikefarah/yq v4"; exit 2; }

# API groups/versions served by the CRDs in the platform-crds bundle (what Argo CD would
# pass as --api-versions on a platform cluster). Only affects conditional CRs, never CRDs.
DEFAULT_API_VERSIONS="acme.cert-manager.io/v1,argoproj.io/v1alpha1,autoscaling.k8s.io/v1,cert-manager.io/v1,\
eventing.keda.sh/v1alpha1,external-secrets.io/v1,external-secrets.io/v1beta1,externaldns.k8s.io/v1alpha1,\
fluentbit.fluent.io/v1alpha2,fluentd.fluent.io/v1alpha1,generators.external-secrets.io/v1alpha1,keda.sh/v1alpha1,\
metacontroller.glueops.dev/v1alpha1,metacontroller.k8s.io/v1alpha1,monitoring.coreos.com/v1,monitoring.coreos.com/v1alpha1,\
platform.glueops.dev/v1alpha1,traefik.io/v1alpha1"
API_VERSIONS="${API_VERSIONS:-$DEFAULT_API_VERSIONS}"

log()  { printf '%s\n' "$*" >&2; }
fail() { printf '::error::%s\n' "$*" >&2; exit 1; }

# ---------------------------------------------------------------------------
# 1. Render the platform chart and pull out the Applications (one JSON per line)
# ---------------------------------------------------------------------------
helm template glueops-platform "$CHART_DIR" -f "$CI_VALUES" > "$WORK/platform.yaml"
yq -o=json -I=0 'select(.kind == "Application")' "$WORK/platform.yaml" > "$WORK/apps.jsonl"
app_count="$(wc -l < "$WORK/apps.jsonl")"
[ "$app_count" -gt 0 ] || fail "no Application rendered from the platform chart"
log "platform chart rendered: $app_count Applications"

# The platform chart itself must not carry a CRD either.
if [ "$(yq -N 'select(.kind == "CustomResourceDefinition") | .metadata.name' "$WORK/platform.yaml" | grep -vc '^---$' || true)" -ne 0 ]; then
  fail "the platform chart renders a CustomResourceDefinition directly"
fi

# ---------------------------------------------------------------------------
# 2. Chart fetchers (cached per repo/chart/revision inside the work dir)
# ---------------------------------------------------------------------------
cache_key() { printf '%s' "$*" | tr -c 'A-Za-z0-9._-' '_'; }

# fetch_chart_repo <repoURL> <chart> <version>  -> prints the chart directory
fetch_chart_repo() {
  local repo="$1" chart="$2" ver="$3"
  local dir; dir="$CACHE/$(cache_key "$repo" "$chart" "$ver")"
  if [ ! -d "$dir/$chart" ]; then
    mkdir -p "$dir"
    case "$repo" in
      http://*|https://*)
        helm pull "$chart" --repo "$repo" --version "$ver" --untar --untardir "$dir" >/dev/null ;;
      *)
        # Argo CD treats a scheme-less Helm repoURL as an OCI registry (enableOCI on the repo).
        helm pull "oci://${repo#oci://}/$chart" --version "$ver" --untar --untardir "$dir" >/dev/null ;;
    esac
  fi
  printf '%s\n' "$dir/$chart"
}

# fetch_git <repoURL> <targetRevision> <path> -> prints the checked-out path
fetch_git() {
  local repo="$1" rev="$2" path="$3"
  local dir; dir="$CACHE/$(cache_key "$repo" "$rev")"
  if [ ! -d "$dir/.git" ]; then
    if ! git clone --quiet --depth 1 --branch "$rev" "$repo" "$dir" 2>/dev/null; then
      # not a tag/branch: full clone and check out the commit
      rm -rf "$dir"
      git clone --quiet "$repo" "$dir"
      git -C "$dir" checkout --quiet "$rev"
    fi
  fi
  printf '%s\n' "$dir/${path#./}"
}

# ---------------------------------------------------------------------------
# 3. Render every Helm source of every Application
# ---------------------------------------------------------------------------
declare -a report=()
crd_total=0
rendered=0
skipped=0

while IFS= read -r app; do
  name="$(jq -r '.metadata.name' <<<"$app")"
  ns="$(jq -r '.spec.destination.namespace // "default"' <<<"$app")"
  n_sources="$(jq -r 'if .spec.sources then (.spec.sources | length) else 1 end' <<<"$app")"

  for ((i = 0; i < n_sources; i++)); do
    src="$(jq -c --argjson i "$i" 'if .spec.sources then .spec.sources[$i] else .spec.source end' <<<"$app")"
    label="$name"; [ "$n_sources" -gt 1 ] && label="$name[$i]"
    repo="$(jq -r '.repoURL' <<<"$src")"
    rev="$(jq -r '.targetRevision // "HEAD"' <<<"$src")"

    # Skip non-Helm sources.
    if jq -e '.ref != null' <<<"$src" >/dev/null; then
      report+=("skip    $label  (values-only \$ref source)"); skipped=$((skipped + 1)); continue
    fi
    if jq -e '.chart == null' <<<"$src" >/dev/null && [[ "$repo" == placeholder_* ]]; then
      report+=("skip    $label  (captain repo placeholder URL)"); skipped=$((skipped + 1)); continue
    fi
    if jq -e '.directory != null' <<<"$src" >/dev/null; then
      # Plain manifests: Argo CD applies every yaml/yml/json under path (recursively if asked).
      dir_path="$(fetch_git "$repo" "$rev" "$(jq -r '.path // "."' <<<"$src")")"
      maxdepth=(-maxdepth 1); jq -e '.directory.recurse == true' <<<"$src" >/dev/null && maxdepth=()
      crds="$(find "$dir_path" "${maxdepth[@]}" -type f \( -name '*.yaml' -o -name '*.yml' -o -name '*.json' \) -print0 \
        | xargs -0 -r yq -N 'select(.kind == "CustomResourceDefinition") | .metadata.name' 2>/dev/null | grep -v '^---$' || true)"
      n_crds=0; [ -z "$crds" ] || n_crds="$(wc -l <<<"$crds")"
      rendered=$((rendered + 1))
      if [ "$n_crds" -gt 0 ]; then
        crd_total=$((crd_total + n_crds))
        report+=("FAIL    $label  (directory source, $n_crds CRDs): $(tr '\n' ' ' <<<"$crds")")
      else
        report+=("ok      $label  (directory source, 0 CRDs)")
      fi
      continue
    fi

    # Locate the chart.
    if jq -e '.chart != null' <<<"$src" >/dev/null; then
      chart_dir="$(fetch_chart_repo "$repo" "$(jq -r '.chart' <<<"$src")" "$rev")"
    else
      chart_dir="$(fetch_git "$repo" "$rev" "$(jq -r '.path // "."' <<<"$src")")"
      if [ ! -f "$chart_dir/Chart.yaml" ]; then
        # Argo CD would treat this as a plain directory source.
        if jq -e '.helm != null' <<<"$src" >/dev/null; then
          fail "$label: helm source but no Chart.yaml at $repo@$rev:$(jq -r '.path' <<<"$src")"
        fi
        report+=("skip    $label  (git directory without Chart.yaml)"); skipped=$((skipped + 1)); continue
      fi
      if yq -e '.dependencies' "$chart_dir/Chart.yaml" >/dev/null 2>&1; then
        helm dependency build "$chart_dir" >/dev/null
      fi
    fi

    # Translate the Application's helm block into helm CLI flags, as Argo CD does.
    args=()
    release="$(jq -r '.helm.releaseName // empty' <<<"$src")"; [ -n "$release" ] || release="$name"
    if jq -e '.helm.skipCrds == true' <<<"$src" >/dev/null; then
      mode="skipCrds"          # Argo CD omits --include-crds
    else
      mode="include-crds"; args+=(--include-crds)
    fi
    [ -n "${KUBE_VERSION:-}" ] && args+=(--kube-version "$KUBE_VERSION")
    IFS=',' read -r -a api_versions <<<"$API_VERSIONS"
    for av in "${api_versions[@]}"; do [ -n "$av" ] && args+=(--api-versions "$av"); done
    vdir="$WORK/values/$(cache_key "$label")"; mkdir -p "$vdir"
    if jq -e '.helm.values != null' <<<"$src" >/dev/null; then
      jq -r '.helm.values' <<<"$src" > "$vdir/values.yaml"; args+=(--values "$vdir/values.yaml")
    fi
    if jq -e '.helm.valuesObject != null' <<<"$src" >/dev/null; then
      jq '.helm.valuesObject' <<<"$src" | yq -P > "$vdir/valuesObject.yaml"; args+=(--values "$vdir/valuesObject.yaml")
    fi
    while IFS= read -r vf; do
      [ -n "$vf" ] || continue
      [[ "$vf" == \$* ]] && fail "$label: valueFiles entry '$vf' references another source; not supported here"
      args+=(--values "$chart_dir/$vf")
    done < <(jq -r '.helm.valueFiles[]? // empty' <<<"$src")
    while IFS=$'\t' read -r pname pvalue pforce; do
      [ -n "$pname" ] || continue
      pvalue="${pvalue//,/\\,}"   # Argo CD escapes commas in --set values
      if [ "$pforce" = "true" ]; then args+=(--set-string "$pname=$pvalue"); else args+=(--set "$pname=$pvalue"); fi
    done < <(jq -r '.helm.parameters[]? | [.name, .value, (.forceString // false | tostring)] | @tsv' <<<"$src")

    out="$vdir/rendered.yaml"
    if ! helm template "$release" "$chart_dir" --namespace "$ns" "${args[@]}" > "$out" 2> "$vdir/stderr"; then
      cat "$vdir/stderr" >&2
      fail "$label: helm template failed for $repo@$rev"
    fi
    crds="$(yq -N 'select(.kind == "CustomResourceDefinition") | .metadata.name' "$out" | grep -v '^---$' || true)"
    n_crds=0; [ -z "$crds" ] || n_crds="$(wc -l <<<"$crds")"
    docs="$(grep -c '^kind:' "$out" || true)"
    rendered=$((rendered + 1))
    if [ "$n_crds" -gt 0 ]; then
      crd_total=$((crd_total + n_crds))
      report+=("FAIL    $label  ($mode, $docs objects, $n_crds CRDs): $(tr '\n' ' ' <<<"$crds")")
    else
      report+=("ok      $label  ($mode, $docs objects, 0 CRDs)")
    fi
  done
done < "$WORK/apps.jsonl"

# ---------------------------------------------------------------------------
# 4. Report
# ---------------------------------------------------------------------------
printf '%s\n' "${report[@]}"
echo "---"
echo "checked $rendered sources across $app_count Applications ($skipped sources skipped); CRDs found: $crd_total"
if [ "$crd_total" -ne 0 ]; then
  fail "$crd_total CustomResourceDefinition(s) rendered by Argo CD Applications; CRDs must come from the platform-crds bundle"
fi
echo "OK: no Argo CD Application renders a CustomResourceDefinition"
