
{{/* Returns the provider server URL (OpenBao or Vault) */}}
{{- define "secretsProvider.server" -}}
{{- required "secretsProvider.address is required" .Values.secretsProvider.address -}}
{{- end -}}

{{/* Common env vars for AVP pointing at OpenBao/Vault */}}
{{- define "secretsProvider.avpEnv" -}}
- name: AVP_TYPE
  value: "vault"
- name: VAULT_ADDR
  value: {{ include "secretsProvider.server" . | quote }}
{{- if eq .Values.secretsProvider.auth.type "kubernetes" }}
- name: AVP_AUTH_TYPE
  value: "kubernetes"
- name: AVP_K8S_ROLE
  value: {{ .Values.secretsProvider.auth.kubernetes.role | quote }}
- name: AVP_K8S_MOUNT_PATH
  value: {{ .Values.secretsProvider.auth.kubernetes.mount | default "kubernetes" | quote }}
{{- else if eq .Values.secretsProvider.auth.type "approle" }}
- name: AVP_AUTH_TYPE
  value: "approle"
- name: AVP_ROLE_ID
  value: {{ .Values.secretsProvider.auth.approle.roleId | quote }}
- name: AVP_SECRET_ID
  valueFrom:
    secretKeyRef:
      name: {{ .Values.secretsProvider.auth.approle.secretIdRef | quote }}
      key: secretId
{{- else if eq .Values.secretsProvider.auth.type "token" }}
- name: VAULT_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .Values.secretsProvider.auth.token.valueFromSecret | quote }}
      key: token
{{- end }}
{{- if or .Values.secretsProvider.caBundle.inlinePEM .Values.secretsProvider.caBundle.secretRef }}
- name: AVP_SSL_CERT_FILE
  value: "/etc/ssl/sp-ca/ca.pem"
{{- end }}
{{- end -}}

{{/* Optional volume + mount snippets for a private CA */}}
{{- define "secretsProvider.caVolume" -}}
{{- if or .Values.secretsProvider.caBundle.inlinePEM .Values.secretsProvider.caBundle.secretRef -}}
- name: sp-ca
  {{- if .Values.secretsProvider.caBundle.inlinePEM }}
  configMap:
    name: sp-ca
  {{- else }}
  secret:
    secretName: {{ .Values.secretsProvider.caBundle.secretRef }}
  {{- end }}
{{- end -}}
{{- end -}}

{{- define "secretsProvider.caMount" -}}
{{- if or .Values.secretsProvider.caBundle.inlinePEM .Values.secretsProvider.caBundle.secretRef -}}
- name: sp-ca
  mountPath: /etc/ssl/sp-ca
  readOnly: true
{{- end -}}
{{- end -}}
