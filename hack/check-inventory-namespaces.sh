#!/usr/bin/env bash
# Proves that the namespace list glueops-core-inventory-agent collects pod images from
# (templates/_inventory_agent.tpl, "glueops.inventoryAgent.chartNamespaces") equals the
# set of Application destination namespaces in this chart plus kube-system.
#
# The agent gets one namespaced pods Role per entry instead of a cluster-wide grant, so
# a new glueops-core-* Application that is not added to the list is silently invisible
# to the inventory, and a listed namespace that no Application creates fails the whole
# Application sync (Argo CD dry-runs every object; `namespaces "x" not found`). Both
# directions are checked, for two values permutations: every gated Application on
# (ci/values.yaml as is) and every gate off (an EKS captain without load balancers).
#
# Usage: hack/check-inventory-namespaces.sh      (needs helm, yq (mikefarah v4))
set -euo pipefail

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CI_VALUES="$CHART_DIR/ci/values.yaml"
for tool in helm yq; do
  command -v "$tool" >/dev/null || { echo "::error::$tool is required"; exit 2; }
done
yq --version 2>&1 | grep -q 'mikefarah' || { echo "::error::yq must be mikefarah/yq v4"; exit 2; }
[ "$(yq -N '.inventory_agent.enabled // true' "$CI_VALUES")" != "false" ] || {
  echo "::error::inventory_agent.enabled is false in ci/values.yaml; the check needs the Application rendered"; exit 2; }

# Extras that ci/values.yaml adds for the test; they are not chart namespaces.
extras="$(yq -N '.inventory_agent.extra_pod_namespaces[]?' "$CI_VALUES" | sort -u)"

# check <label> [extra helm args...]: compares declared vs deployed for one permutation.
check() {
  local label="$1"; shift
  local rendered declared deployed missing stale
  rendered="$(helm template x "$CHART_DIR" -f "$CI_VALUES" "$@")"

  # What the chart declares: the POD_NAMESPACES env the Application hands the agent,
  # evaluated exactly as the Application does.
  declared="$(printf '%s\n' "$rendered" \
    | yq -N 'select(.kind == "Application" and .metadata.name == "glueops-core-inventory-agent") | .spec.source.helm.values' \
    | yq -N '.cronJob.jobs.snapshot.envVariables[] | select(.name == "POD_NAMESPACES") | .value' \
    | tr ',' '\n' | sort -u)"
  [ -n "$declared" ] || { echo "::error::[$label] glueops-core-inventory-agent did not render"; return 1; }
  declared="$(comm -23 <(printf '%s\n' "$declared") <(printf '%s\n' "$extras"))"

  # What the chart deploys: every Application's spec.destination.namespace plus
  # kube-system, minus the agent's own namespace (its only pod is the agent).
  deployed="$( (printf '%s\n' "$rendered" | yq -N 'select(.kind == "Application") | .spec.destination.namespace'; echo kube-system) \
    | grep -v '^---$' | grep -v '^glueops-core-inventory-agent$' | sort -u)"

  missing="$(comm -13 <(printf '%s\n' "$declared") <(printf '%s\n' "$deployed") || true)"
  stale="$(comm -23 <(printf '%s\n' "$declared") <(printf '%s\n' "$deployed") || true)"
  local ok=0
  if [ -n "$missing" ]; then
    printf '::error::[%s] Application destination namespaces missing from glueops.inventoryAgent.chartNamespaces:\n%s\n' "$label" "$missing" >&2; ok=1
  fi
  if [ -n "$stale" ]; then
    printf '::error::[%s] glueops.inventoryAgent.chartNamespaces lists namespaces no Application deploys to (the sync would fail):\n%s\n' "$label" "$stale" >&2; ok=1
  fi
  [ "$ok" -eq 0 ] && echo "ok  [$label] $(wc -l <<<"$deployed" | tr -d ' ') namespaces match"
  return "$ok"
}

status=0
check "gates on" || status=1
check "gates off" \
  --set kubeadm.enabled=false \
  --set nginx.public_lb.enabled=false \
  --set traefik.internal_lb.enabled=false \
  --set traefik.public_lb.enabled=false || status=1
[ "$status" -eq 0 ] && echo "OK: inventory-agent namespace list matches the chart's Applications in both permutations"
exit "$status"
