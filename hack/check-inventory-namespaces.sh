#!/usr/bin/env bash
# Proves that the namespace list glueops-core-inventory-agent collects pod images from
# (templates/_inventory_agent.tpl, "glueops.inventoryAgent.chartNamespaces") equals the
# set of Application destination namespaces in this chart plus kube-system.
#
# The agent gets one namespaced pods Role per entry instead of a cluster-wide grant, so
# a new glueops-core-* Application that is not added to the list is silently invisible
# to the inventory. This check turns that into a CI failure.
#
# Usage: hack/check-inventory-namespaces.sh      (needs helm, yq (mikefarah v4))
set -euo pipefail

CHART_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for tool in helm yq; do
  command -v "$tool" >/dev/null || { echo "::error::$tool is required"; exit 2; }
done

# What the chart declares (rendered through a throwaway template so the named
# template is evaluated exactly as the Application does).
declared="$(helm template x "$CHART_DIR" -f "$CHART_DIR/ci/values.yaml" \
  --show-only templates/application-inventory-agent.yaml \
  | yq -N '.spec.source.helm.values' \
  | yq -N '.cronJob.jobs.snapshot.envVariables[] | select(.name == "POD_NAMESPACES") | .value' \
  | tr ',' '\n' | sort -u)"

# What the chart actually deploys: every Application's spec.destination.namespace,
# plus kube-system, minus extras that ci/values.yaml adds for the test.
extras="$(yq -N '.inventory_agent.extra_pod_namespaces[]?' "$CHART_DIR/ci/values.yaml" | sort -u)"
deployed="$( (helm template x "$CHART_DIR" -f "$CHART_DIR/ci/values.yaml" \
  | yq -N 'select(.kind == "Application") | .spec.destination.namespace'; echo kube-system) \
  | grep -v '^---$' | grep -v '^glueops-core-inventory-agent$' | sort -u)"
declared_without_extras="$(comm -23 <(printf '%s\n' "$declared") <(printf '%s\n' "$extras"))"

missing="$(comm -13 <(printf '%s\n' "$declared_without_extras") <(printf '%s\n' "$deployed") || true)"
stale="$(comm -23 <(printf '%s\n' "$declared_without_extras") <(printf '%s\n' "$deployed") || true)"

status=0
if [ -n "$missing" ]; then
  printf '::error::Application destination namespaces missing from glueops.inventoryAgent.chartNamespaces:\n%s\n' "$missing" >&2
  status=1
fi
if [ -n "$stale" ]; then
  printf '::error::glueops.inventoryAgent.chartNamespaces lists namespaces no Application deploys to:\n%s\n' "$stale" >&2
  status=1
fi
[ "$status" -eq 0 ] && echo "OK: inventory-agent namespace list matches the chart's $(wc -l <<<"$deployed" | tr -d ' ') destination namespaces"
exit "$status"
