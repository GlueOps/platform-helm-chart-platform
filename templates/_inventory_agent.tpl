{{- /*
Namespaces whose pod images glueops-core-inventory-agent collects. One namespaced
Role is rendered per entry (application-inventory-agent.yaml), never a cluster-wide
pods grant: tenant pods carry literal env values and must stay unreadable.

Keep this equal to the set of `spec.destination.namespace` values across the
Application templates in this chart plus kube-system; hack/check-inventory-namespaces.sh
fails CI when they drift. Adding or removing an Application therefore means editing
this list in the same PR (the OTel monitoring migration, for one, replaces the
kube-prometheus-stack / loki / promtail namespaces with glueops-core-monitoring). Namespaces that come from the captain repo rather than this
chart (glueops-core-monitoring, glueops-core-gatekeeper, ...) are added per cluster via
.Values.inventory_agent.extra_pod_namespaces.
*/ -}}
{{- define "glueops.inventoryAgent.chartNamespaces" -}}
- kube-system
- glueops-core
- glueops-core-alerts
- glueops-core-backup
- glueops-core-ccm
- glueops-core-cert-manager
- glueops-core-cluster-info-page
- glueops-core-dex
- glueops-core-external-dns
- glueops-core-external-secrets
- glueops-core-fluent-operator
- glueops-core-go-healthz
- glueops-core-goldilocks
- glueops-core-internal-traefik
- glueops-core-keda
- glueops-core-kube-prometheus-stack
- glueops-core-loki
- glueops-core-loki-alert-group-controller
- glueops-core-metacontroller
- glueops-core-network-exporter
- glueops-core-oauth2-proxy
- glueops-core-platform-traefik
- glueops-core-promtail
- glueops-core-public-ingress-nginx
- glueops-core-public-traefik
- glueops-core-pull-request-bot
- glueops-core-qr-code-generator
- glueops-core-reflector
- glueops-core-traefik-crds
- glueops-core-vault
- glueops-core-vpa
{{- end -}}

{{- /*
Full, validated list: chart namespaces + extras. Every extra must match glueops-core*;
anything else fails the render so a tenant namespace can never be added by mistake.
*/ -}}
{{- define "glueops.inventoryAgent.podNamespaces" -}}
{{- $all := fromYamlArray (include "glueops.inventoryAgent.chartNamespaces" .) -}}
{{- range $ns := .Values.inventory_agent.extra_pod_namespaces }}
  {{- if not (hasPrefix "glueops-core" $ns) }}
    {{- fail (printf "inventory_agent.extra_pod_namespaces: %q is not a platform namespace (must match glueops-core*)" $ns) }}
  {{- end }}
  {{- if not (has $ns $all) }}
    {{- $all = append $all $ns }}
  {{- end }}
{{- end }}
{{- toYaml $all -}}
{{- end -}}
