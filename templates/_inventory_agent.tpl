{{- /*
Namespaces whose pod images glueops-core-inventory-agent collects. One namespaced
Role is rendered per entry (application-inventory-agent.yaml), never a cluster-wide
pods grant: tenant pods carry literal env values and must stay unreadable.

Every entry MUST exist on the cluster the moment the Application syncs. Argo CD
dry-runs all objects before applying any; one Role aimed at a missing namespace
fails the whole sync (`namespaces "x" not found`) and nothing is applied. So an
Application that is gated on a value is listed under the same gate here, and the
list is kept equal to the set of `spec.destination.namespace` values across the
Application templates (plus kube-system); hack/check-inventory-namespaces.sh fails
CI when they drift, for the gates-on and the gates-off permutation. Adding or
removing an Application therefore means editing this list in the same PR (the
OTel monitoring migration, for one, replaces the kube-prometheus-stack / loki /
promtail namespaces with glueops-core-monitoring).

Namespaces that come from the captain repo rather than this chart
(glueops-core-monitoring, glueops-core-gatekeeper, ...) are added per cluster via
.Values.inventory_agent.extra_pod_namespaces, with the same must-exist rule.
*/ -}}
{{- define "glueops.inventoryAgent.chartNamespaces" -}}
- kube-system
- glueops-core
- glueops-core-alerts
- glueops-core-backup
{{- if .Values.kubeadm.enabled }}
- glueops-core-ccm
{{- end }}
- glueops-core-cert-manager
- glueops-core-cluster-info-page
- glueops-core-dex
- glueops-core-external-dns
- glueops-core-external-secrets
- glueops-core-fluent-operator
- glueops-core-go-healthz
{{- if .Values.kubeadm.enabled }}
- glueops-core-goldilocks
{{- end }}
{{- if .Values.traefik.internal_lb.enabled }}
- glueops-core-internal-traefik
{{- end }}
- glueops-core-keda
- glueops-core-kube-prometheus-stack
- glueops-core-loki
- glueops-core-loki-alert-group-controller
- glueops-core-metacontroller
- glueops-core-network-exporter
- glueops-core-oauth2-proxy
- glueops-core-platform-traefik
- glueops-core-promtail
{{- if .Values.nginx.public_lb.enabled }}
- glueops-core-public-ingress-nginx
{{- end }}
{{- if .Values.traefik.public_lb.enabled }}
- glueops-core-public-traefik
{{- end }}
- glueops-core-pull-request-bot
- glueops-core-qr-code-generator
- glueops-core-reflector
- glueops-core-traefik-crds
- glueops-core-vault
{{- if .Values.kubeadm.enabled }}
- glueops-core-vpa
{{- end }}
{{- end -}}

{{- /*
Full, validated list: chart namespaces + extras. Every extra must be glueops-core
itself or carry the glueops-core- prefix; anything else fails the render so a tenant
namespace can never be added by mistake.
*/ -}}
{{- define "glueops.inventoryAgent.podNamespaces" -}}
{{- $all := fromYamlArray (include "glueops.inventoryAgent.chartNamespaces" .) -}}
{{- range $ns := .Values.inventory_agent.extra_pod_namespaces }}
  {{- if not (or (eq $ns "glueops-core") (hasPrefix "glueops-core-" $ns)) }}
    {{- fail (printf "inventory_agent.extra_pod_namespaces: %q is not a platform namespace (must be glueops-core or glueops-core-*)" $ns) }}
  {{- end }}
  {{- if not (has $ns $all) }}
    {{- $all = append $all $ns }}
  {{- end }}
{{- end }}
{{- toYaml $all -}}
{{- end -}}
