
# OpenBao support bundle for GlueOps Platform Helm Chart

This bundle gives you **drop‑in templates and values** to add OpenBao support next to Vault.
It’s designed to be copied into your chart (or a subchart) and enabled via values.

You’ll get:
- A **provider-agnostic `secretsProvider` block** for values (OpenBao or Vault).
- Helper templates to **inject env vars and trust** into workloads (AVP & ESO).
- Optional manifests to **mount a private CA**.
- An **example ExternalSecret** targeting OpenBao.
- A **safe `kubectl patch`** you can run to add the AVP sidecar to `argocd-repo-server` without changing its chart (optional).

> Note: Argo CD Vault Plugin (AVP) treats OpenBao like Vault (same API). Keep `AVP_TYPE=vault`, just point `VAULT_ADDR` at your OpenBao URL.

---

## How to use

### 1) Copy these files into your chart
Recommended locations (you can change if your repo uses different paths):

```
charts/platform/
  values-openbao.yaml
  templates/_helpers.secretsprovider.tpl
  templates/secretsprovider-ca.yaml
  templates/externalsecret-example.yaml
  optional/argocd-repo-server-avp-sidecar-patch.yaml
```

> If your chart already has `_helpers.tpl`, keep this one separate (name ends with `.secretsprovider.tpl`) so there’s no merge conflict.

### 2) Wire up values
Start with `values-openbao.yaml` and adjust:

```yaml
secretsProvider:
  kind: openbao
  address: https://openbao.platform.example:8200

  auth:
    type: kubernetes
    kubernetes:
      role: argocd
      mount: kubernetes

  # Use one of the CA options if you're on a private PKI
  caBundle:
    inlinePEM: |
      -----BEGIN CERTIFICATE-----
      ...your CA here...
      -----END CERTIFICATE-----
    # secretRef: ""   # alternative to inlinePEM
```

Apply this values file when you install/upgrade your chart.

### 3) (Optional) Mount your private CA for AVP/clients
If you provided `secretsProvider.caBundle.inlinePEM`, the `secretsprovider-ca.yaml` template will create a `ConfigMap` named `sp-ca` with the CA at `data.ca.pem`.
Mount it at `/etc/ssl/sp-ca/ca.pem` and set `AVP_SSL_CERT_FILE=/etc/ssl/sp-ca/ca.pem` in the AVP sidecar (see the patch below).

### 4) (Optional) Add AVP sidecar to argocd-repo-server (no chart changes)
If your platform chart does **not** manage the `argocd-repo-server` Deployment, you can patch it in place with `kubectl`:

```bash
# Set your values:
NS=argocd
OPENBAO_URL="https://openbao.platform.example:8200"
K8S_ROLE="argocd"
K8S_MOUNT="kubernetes"
CA_PATH="/etc/ssl/sp-ca/ca.pem"        # leave as-is if you mount the sp-ca configmap

kubectl -n $NS patch deploy argocd-repo-server --type='json' -p='[
  {"op":"add","path":"/spec/template/spec/volumes/-","value":{"name":"sp-ca","configMap":{"name":"sp-ca"}}},
  {"op":"add","path":"/spec/template/spec/containers/-","value":{
    "name":"avp",
    "image":"ghcr.io/argoproj-labs/argocd-vault-plugin:latest",
    "args":["generate","/tmp/app"],
    "env":[
      {"name":"AVP_TYPE","value":"vault"},
      {"name":"VAULT_ADDR","value":"'"$OPENBAO_URL"'"},
      {"name":"AVP_AUTH_TYPE","value":"kubernetes"},
      {"name":"AVP_K8S_ROLE","value":"'"$K8S_ROLE"'"},
      {"name":"AVP_K8S_MOUNT_PATH","value":"'"$K8S_MOUNT"'"},
      {"name":"AVP_SSL_CERT_FILE","value":"'"$CA_PATH"'"
      }
    ],
    "volumeMounts":[{"name":"sp-ca","mountPath":"/etc/ssl/sp-ca","readOnly":true}]
  }}
]'
```

If you use **AppRole** or **Token** instead of Kubernetes auth, change the env block:
- AppRole: set `AVP_ROLE_ID` and `AVP_SECRET_ID` (use `valueFrom.secretKeyRef` for secret_id).
- Token: set `VAULT_TOKEN` via `valueFrom.secretKeyRef`.

### 5) External Secrets Operator (if you use it)
Use `externalsecret-example.yaml` as a model. The only difference is the `server:` URL and auth, which now comes from the same values.

### 6) Roll out & test
- Sync a test Argo CD application containing AVP placeholders like `<path:kv/myapp#DB_PASSWORD>`.
- Watch the `argocd-repo-server` pod logs (main + `avp` sidecar) for any 403/404.
- Verify ExternalSecret resources reconcile against OpenBao.

---

## File inventory

- `values-openbao.yaml` — values overlay for OpenBao/Vault neutrality
- `templates/_helpers.secretsprovider.tpl` — helpers to inject env and URLs
- `templates/secretsprovider-ca.yaml` — optional CA ConfigMap renderer
- `templates/externalsecret-example.yaml` — example ExternalSecret using the helpers
- `optional/argocd-repo-server-avp-sidecar-patch.yaml` — a templated manifest showing how the sidecar env/volumes should look (for reference)
