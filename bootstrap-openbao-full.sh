#!/usr/bin/env bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────────────────────
# Help / Usage
# ────────────────────────────────────────────────────────────────────────────────
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${HELP:-}" == "1" ]]; then
  cat <<'USAGE'
OpenBao Bootstrap (install, init, unseal, ESO + OIDC wiring)

Prereqs:
  - kubectl, helm, jq in PATH
  - Kubernetes access to your cluster
  - (Optional) Valid Dex client for OIDC: client_id + client_secret

What this script does (high level):
  1) Uninstalls any existing OpenBao release + cleans PVC/PV finalizers.
  2) Installs OpenBao via Helm and waits for pods Running.
  3) Initializes Bao (prints UNSEAL_KEY + ROOT_TOKEN) if not initialized.
  4) Unseals leader, joins followers to raft, unseals followers.
  5) (Optional) Configures External Secrets Operator (ESO) Kubernetes auth.
  6) (Optional) Configures OIDC auth against Dex, binds groups -> policies.
  7) Prints a ClusterSecretStore snippet (and can apply it).

Required environment (typical):
  # OpenBao ingress host (used for OIDC redirect URI)
  export BAO_PUBLIC_URL="https://openbao.nonprod.earth.onglueops.rocks"

  # OIDC with Dex (if ENABLE_OIDC=1)
  export OIDC_CLIENT_ID="openbao"
  export OIDC_CLIENT_SECRET="REDACTED"
  export OIDC_DISCOVERY_URL="https://dex.nonprod.earth.onglueops.rocks"

Strongly recommended environment:
  # bind groups to Bao policies:
  # - editor (CRUD on kv)
  # - reader (read-only kv)
  export OIDC_ADMIN_GROUPS="my-org:platform-editors"
  export OIDC_READONLY_GROUPS="glueops-rocks:super_admins,development-tenant-earth:developers"

Other useful environment (defaults shown):
  # Names/versions
  export NS="glueops-core-boa"                      # OpenBao namespace
  export REL="openbao"                              # Helm release name
  export VALUES_FILE="values-openbao.yaml"          # Helm values file
  # export CHART_VERSION=""                         # empty = latest repo

  # Init shares/threshold
  export SHARES="1"
  export THRESHOLD="1"

  # ESO wiring
  export CONFIGURE_ESO="1"                          # 1=on, 0=off
  export ESO_NS="glueops-core-external-secrets"
  # export ESO_SA=""                                # auto-detected if empty
  export EXTRA_ESO_SAS="external-secrets-read-all-from-vault"  # CSV

  # KV mount used by ESO & OIDC policies
  export KV_PATH="kv"

  # Demo seed
  export SEED_DEMO="1"

  # ClusterSecretStore output/apply
  export PRINT_STORE_SNIPPET="1"
  export APPLY_STORE="0"                            # 1 to kubectl apply
  export STORE_NAME="vault-backend"

Examples:

  # Basic end-to-end with OIDC groups:
  export OIDC_CLIENT_ID=openbao
  export OIDC_CLIENT_SECRET=REDACTED
  export OIDC_ADMIN_GROUPS='my-org:platform-editors'
  export OIDC_READONLY_GROUPS='glueops-rocks:super_admins,development-tenant-earth:developers'
  ./bootstrap-openbao-full.sh

  # Different namespace + auto-apply ClusterSecretStore:
  NS=glueops-core-boa APPLY_STORE=1 ./bootstrap-openbao-full.sh

  # Disable ESO wiring (just install+init+OIDC):
  CONFIGURE_ESO=0 ./bootstrap-openbao-full.sh

Notes:
  - Script prints UNSEAL_KEY and ROOT_TOKEN on a fresh init. Handle securely.
  - For OIDC CLI login, use: bao login -method=oidc -path=oidc
  - Dex groups must match the "groups" claim emitted by Dex (often "org:team").
USAGE
  exit 0
fi

# ────────────────────────────────────────────────────────────────────────────────
# Config (override via env)
# ────────────────────────────────────────────────────────────────────────────────
NS="${NS:-glueops-core-boa}"
REL="${REL:-openbao}"
VALUES_FILE="${VALUES_FILE:-values-openbao.yaml}"
CHART_VERSION="${CHART_VERSION:-}"

SHARES="${SHARES:-1}"
THRESHOLD="${THRESHOLD:-1}"

# ESO wiring
CONFIGURE_ESO="${CONFIGURE_ESO:-1}"
ESO_NS="${ESO_NS:-glueops-core-external-secrets}"
ESO_SA="${ESO_SA:-}"
EXTRA_ESO_SAS="${EXTRA_ESO_SAS:-external-secrets-read-all-from-vault}"

# KV mount to use
KV_PATH="${KV_PATH:-kv}"

# Seed a demo secret?
SEED_DEMO="${SEED_DEMO:-1}"

# ClusterSecretStore output/apply
PRINT_STORE_SNIPPET="${PRINT_STORE_SNIPPET:-1}"
APPLY_STORE="${APPLY_STORE:-0}"
STORE_NAME="${STORE_NAME:-vault-backend}"

# ----- OIDC (Dex) -----
ENABLE_OIDC="${ENABLE_OIDC:-1}"
OIDC_DISCOVERY_URL="${OIDC_DISCOVERY_URL:-https://dex.nonprod.earth.onglueops.rocks}"
BAO_PUBLIC_URL="${BAO_PUBLIC_URL:-https://openbao.nonprod.earth.onglueops.rocks}"
OIDC_CLIENT_ID="${OIDC_CLIENT_ID:-}"
OIDC_CLIENT_SECRET="${OIDC_CLIENT_SECRET:-}"
# CSV lists
OIDC_ADMIN_GROUPS="${OIDC_ADMIN_GROUPS:-}"         # → editor policy
OIDC_READONLY_GROUPS="${OIDC_READONLY_GROUPS:-}"   # → reader policy
# legacy singles (merged into CSV if set)
OIDC_ADMIN_GROUP="${OIDC_ADMIN_GROUP:-}"
OIDC_READONLY_GROUP="${OIDC_READONLY_GROUP:-}"

# ────────────────────────────────────────────────────────────────────────────────
# Pre-flight
# ────────────────────────────────────────────────────────────────────────────────
command -v kubectl >/dev/null || { echo "kubectl not found"; exit 1; }
command -v jq >/dev/null || { echo "jq not found (please install jq)"; exit 1; }

echo "==> OpenBao full bootstrap: NS=$NS REL=$REL VALUES=$VALUES_FILE"

# ────────────────────────────────────────────────────────────────────────────────
# Nuke old install
# ────────────────────────────────────────────────────────────────────────────────
echo "==> Uninstalling old Helm release (if any)…"
helm uninstall "$REL" -n "$NS" || true

echo "==> Deleting leftover resources for release=$REL in ns=$NS…"
kubectl -n "$NS" delete statefulset,svc,ingress,cm,secret \
  -l app.kubernetes.io/instance="$REL" --ignore-not-found
kubectl -n "$NS" delete svc "$REL" "$REL-active" "$REL-standby" "$REL-internal" --ignore-not-found || true
kubectl -n "$NS" delete ingress "$REL" --ignore-not-found || true

echo "==> Deleting PVCs (Raft data)…"
kubectl -n "$NS" delete pvc -l app.kubernetes.io/instance="$REL" --ignore-not-found || true

echo "==> Removing finalizers from any stuck PVC/PV…"
for pvc in $(kubectl -n "$NS" get pvc -o name 2>/dev/null | grep "$REL" || true); do
  kubectl -n "$NS" patch "$pvc" -p '{"metadata":{"finalizers":[]}}' --type=merge || true
done
for pv in $(kubectl get pv -o name 2>/dev/null | grep "$REL" || true); do
  kubectl patch "$pv" -p '{"metadata":{"finalizers":[]}}' --type=merge || true
done

# ────────────────────────────────────────────────────────────────────────────────
# Fresh install via Helm
# ────────────────────────────────────────────────────────────────────────────────
echo "==> Adding/updating Helm repo…"
helm repo add openbao https://openbao.github.io/openbao-helm >/dev/null 2>&1 || true
helm repo update >/dev/null

echo "==> Installing OpenBao…"
set -x
helm upgrade --install "$REL" openbao/openbao \
  -n "$NS" \
  -f "$VALUES_FILE" \
  ${CHART_VERSION:+--version "$CHART_VERSION"} \
  --wait --timeout 10m \
  --create-namespace
set +x

# ────────────────────────────────────────────────────────────────────────────────
# Wait for pods Running (0/1 while sealed is fine)
# ────────────────────────────────────────────────────────────────────────────────
REPLICAS="$(kubectl -n "$NS" get sts "$REL" -o jsonpath='{.spec.replicas}')"
echo "==> Waiting for $REPLICAS pods to be in phase=Running…"
for (( i=0; i<REPLICAS; i++ )); do
  POD="${REL}-${i}"
  until [[ "$(kubectl -n "$NS" get pod "$POD" -o jsonpath='{.status.phase}' 2>/dev/null || echo pending)" == "Running" ]]; do
    sleep 2
  done
done

LEADER="${REL}-0"

# ────────────────────────────────────────────────────────────────────────────────
# Helpers
# ────────────────────────────────────────────────────────────────────────────────
bao_status_json() { kubectl -n "$NS" exec "$1" -- sh -lc 'bao status -format=json || true' 2>/dev/null; }
wait_status_json() {
  local pod="$1"; for _ in $(seq 1 60); do
    local js; js="$(bao_status_json "$pod")"
    if [[ -n "$js" ]] && jq -e . >/dev/null 2>&1 <<<"$js"; then echo "$js"; return 0; fi
    sleep 2
  done; return 1
}
is_initialized() { local js; js="$(wait_status_json "$LEADER" || echo '')"; [[ -z "$js" ]] && { echo false; return; }; jq -r '.initialized // false' <<<"$js"; }
is_sealed_pod() { local js; js="$(bao_status_json "$1")"; jq -r '.sealed // false' <<<"$js"; }

# ────────────────────────────────────────────────────────────────────────────────
# Initialize (print UNSEAL_KEY + ROOT_TOKEN)
# ────────────────────────────────────────────────────────────────────────────────
if [[ "$(is_initialized)" == "true" ]]; then
  echo "==> Bao already initialized."
else
  echo "==> Initializing Bao (shares=$SHARES threshold=$THRESHOLD)…"
  INIT_JSON="$(kubectl -n "$NS" exec "$LEADER" -- bao operator init -key-shares="$SHARES" -key-threshold="$THRESHOLD" -format=json )"
  UNSEAL_KEY="$(jq -r '.unseal_keys_b64[0]' <<<"$INIT_JSON")"
  ROOT_TOKEN="$(jq -r '.root_token' <<<"$INIT_JSON")"
  if [[ -z "$UNSEAL_KEY" || -z "$ROOT_TOKEN" || "$UNSEAL_KEY" == "null" || "$ROOT_TOKEN" == "null" ]]; then
    echo "!! Failed to parse init output:"; echo "$INIT_JSON"; exit 1
  fi
  echo; echo "================= OPENBAO INIT OUTPUT ================="
  echo "UNSEAL_KEY=${UNSEAL_KEY}"; echo "ROOT_TOKEN=${ROOT_TOKEN}"
  echo "======================================================="; echo
  export UNSEAL_KEY ROOT_TOKEN
fi

# ────────────────────────────────────────────────────────────────────────────────
# Unseal leader BEFORE any raft join
# ────────────────────────────────────────────────────────────────────────────────
if [[ -n "${UNSEAL_KEY:-}" && "$(is_sealed_pod "$LEADER")" == "true" ]]; then
  echo "==> Unsealing leader: $LEADER"
  kubectl -n "$NS" exec "$LEADER" -- bao operator unseal "$UNSEAL_KEY" >/dev/null
fi

# ────────────────────────────────────────────────────────────────────────────────
# Join + unseal followers
# ────────────────────────────────────────────────────────────────────────────────
for (( i=1; i<REPLICAS; i++ )); do
  POD="${REL}-${i}"
  echo "==> Ensuring raft join for: $POD"
  kubectl -n "$NS" exec "$POD" -- bao operator raft join "http://${REL}-0.${REL}-internal:8200" >/dev/null 2>&1 || true
  if [[ -n "${UNSEAL_KEY:-}" && "$(is_sealed_pod "$POD")" == "true" ]]; then
    echo "==> Unsealing follower: $POD"
    kubectl -n "$NS" exec "$POD" -- bao operator unseal "$UNSEAL_KEY" >/dev/null || true
  fi
done

echo "==> Cluster pods:"; kubectl -n "$NS" get pods -l app.kubernetes.io/instance="$REL" -o wide
echo "==> Bao status (leader):"; kubectl -n "$NS" exec "$LEADER" -- sh -lc 'bao status || true'

# ────────────────────────────────────────────────────────────────────────────────
# Configure for ESO (Kubernetes auth + policy + role)
# ────────────────────────────────────────────────────────────────────────────────
if [[ "${CONFIGURE_ESO}" == "1" ]]; then
  if [[ "$(is_sealed_pod "$LEADER")" == "true" ]]; then
    echo "!! Bao is sealed; skipping ESO config. Unseal and re-run."; exit 1
  fi

  echo "==> Configuring Bao for External Secrets…"
  if [[ -z "$ESO_SA" ]]; then
    ESO_SA="$(kubectl -n "$ESO_NS" get deploy -l app.kubernetes.io/name=external-secrets -o jsonpath='{.items[0].spec.template.spec.serviceAccountName}')"
  fi
  [[ -z "$ESO_SA" ]] && { echo "!! Could not detect ESO SA in $ESO_NS"; exit 1; }

  AUTH_SAS="$ESO_SA"; [[ -n "$EXTRA_ESO_SAS" ]] && AUTH_SAS="$AUTH_SAS,$EXTRA_ESO_SAS"
  AUTH_SAS="$(echo "$AUTH_SAS" | sed 's/,,*/,/g;s/^,\|,$//g')"

  kubectl -n "$NS" exec "$LEADER" -- env KV_PATH="$KV_PATH" ESO_NS="$ESO_NS" AUTH_SAS="$AUTH_SAS" ROOT_TOKEN="${ROOT_TOKEN:-}" sh -lc '
set -e
if [ -n "$ROOT_TOKEN" ]; then bao login "$ROOT_TOKEN" >/dev/null; fi
if ! bao secrets list -format=json | jq -e ".[\"$KV_PATH/\"]" >/dev/null; then
  bao secrets enable -path="$KV_PATH" kv-v2
fi
bao auth enable kubernetes >/dev/null 2>&1 || true
bao write auth/kubernetes/config \
  token_reviewer_jwt=@/var/run/secrets/kubernetes.io/serviceaccount/token \
  kubernetes_host="https://kubernetes.default.svc:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt >/dev/null
cat >/tmp/eso-read.hcl <<EOF
path "'"$KV_PATH"'/data/apps/*"     { capabilities = ["read"] }
path "'"$KV_PATH"'/metadata/apps/*" { capabilities = ["list","read"] }
EOF
bao policy write eso-read /tmp/eso-read.hcl >/dev/null
bao write auth/kubernetes/role/eso-syncer \
  bound_service_account_names="$AUTH_SAS" \
  bound_service_account_namespaces="$ESO_NS" \
  policies="eso-read" ttl="24h" >/dev/null
echo "   -> Kubernetes auth configured: role=eso-syncer; SAs=$AUTH_SAS in ns=$ESO_NS"
'
  if [[ "${SEED_DEMO}" == "1" ]]; then
    echo "==> Seeding demo secret at ${KV_PATH}/apps/demo/db"
    kubectl -n "$NS" exec "$LEADER" -- env KV_PATH="$KV_PATH" ROOT_TOKEN="${ROOT_TOKEN:-}" sh -lc '
set -e
if [ -n "$ROOT_TOKEN" ]; then bao login "$ROOT_TOKEN" >/dev/null; fi
bao kv put "$KV_PATH"/apps/demo/db username=dbuser password=supersecret >/dev/null
'
  fi
fi

# ────────────────────────────────────────────────────────────────────────────────
# Configure OIDC (Dex) with editor/reader policies
# ────────────────────────────────────────────────────────────────────────────────
if [[ "${ENABLE_OIDC}" == "1" ]]; then
  if [[ -z "$OIDC_CLIENT_ID" || -z "$OIDC_CLIENT_SECRET" ]]; then
    echo "!! ENABLE_OIDC=1 but OIDC_CLIENT_ID/SECRET not set. Skipping OIDC config."
  elif [[ "$(is_sealed_pod "$LEADER")" == "true" ]]; then
    echo "!! Bao is sealed; skipping OIDC config. Unseal and re-run."
  else
    echo "==> Configuring OIDC (Dex)…"
    kubectl -n "$NS" exec "$LEADER" -- env \
      ROOT_TOKEN="${ROOT_TOKEN:-}" \
      OIDC_DISCOVERY_URL="$OIDC_DISCOVERY_URL" \
      OIDC_CLIENT_ID="$OIDC_CLIENT_ID" \
      OIDC_CLIENT_SECRET="$OIDC_CLIENT_SECRET" \
      BAO_PUBLIC_URL="$BAO_PUBLIC_URL" \
      KV_PATH="$KV_PATH" \
      OIDC_ADMIN_GROUPS="$OIDC_ADMIN_GROUPS" \
      OIDC_READONLY_GROUPS="$OIDC_READONLY_GROUPS" \
      OIDC_ADMIN_GROUP="$OIDC_ADMIN_GROUP" \
      OIDC_READONLY_GROUP="$OIDC_READONLY_GROUP" \
      sh -lc '
set -e
if [ -n "$ROOT_TOKEN" ]; then bao login "$ROOT_TOKEN" >/dev/null; fi

# enable & configure oidc auth
bao auth enable oidc >/dev/null 2>&1 || true
bao write auth/oidc/config \
  oidc_discovery_url="$OIDC_DISCOVERY_URL" \
  oidc_client_id="$OIDC_CLIENT_ID" \
  oidc_client_secret="$OIDC_CLIENT_SECRET" \
  default_role="default" >/dev/null

# UI + CLI callback URIs
REDIRECT_UI="$BAO_PUBLIC_URL/ui/vault/auth/oidc/oidc/callback"
REDIRECT_CLI="http://127.0.0.1:8250/oidc/callback"

bao write auth/oidc/role/default \
  allowed_redirect_uris="$REDIRECT_UI" \
  allowed_redirect_uris="$REDIRECT_CLI" \
  bound_audiences="$OIDC_CLIENT_ID" \
  user_claim="email" \
  oidc_scopes="openid,profile,email,groups" \
  groups_claim="groups" \
  policies="default" >/dev/null

# Policies
cat >/tmp/editor.hcl <<EOF
path "sys/health"              { capabilities = ["read","list"] }
path "sys/mounts"              { capabilities = ["read"] }
path "'"$KV_PATH"'/metadata/*" { capabilities = ["list","read"] }
path "'"$KV_PATH"'/data/*"     { capabilities = ["create","read","update","delete"] }
EOF
bao policy write editor /tmp/editor.hcl >/dev/null

cat >/tmp/reader.hcl <<EOF
path "sys/health"              { capabilities = ["read","list"] }
path "sys/mounts"              { capabilities = ["read"] }
path "'"$KV_PATH"'/metadata/*" { capabilities = ["list","read"] }
path "'"$KV_PATH"'/data/*"     { capabilities = ["read"] }
EOF
bao policy write reader /tmp/reader.hcl >/dev/null

# Merge legacy singles into CSVs
[ -n "$OIDC_ADMIN_GROUP" ]    && { OIDC_ADMIN_GROUPS="${OIDC_ADMIN_GROUPS:+$OIDC_ADMIN_GROUPS,}$OIDC_ADMIN_GROUP"; }
[ -n "$OIDC_READONLY_GROUP" ] && { OIDC_READONLY_GROUPS="${OIDC_READONLY_GROUPS:+$OIDC_READONLY_GROUPS,}$OIDC_READONLY_GROUP"; }

# helpers
trim() { printf "%s" "$1" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*\$//" -e "s/^\"//" -e "s/\"\$//"; }
ACCESSOR="$(bao auth list -format=json | jq -r ".\"oidc/\".accessor")"

# CSV → editor
if [ -n "$OIDC_ADMIN_GROUPS" ]; then
  echo "$OIDC_ADMIN_GROUPS" | tr "," "\n" | while read -r G; do
    G="$(trim "$G")"; [ -z "$G" ] && continue
    GROUP_ID=$(bao read -format=json identity/group/name/"$G" 2>/dev/null | jq -r ".data.id // empty")
    if [ -z "$GROUP_ID" ]; then
      GROUP_ID=$(bao write -format=json identity/group name="$G" type="external" policies="editor" | jq -r ".data.id")
    else
      bao write identity/group id="$GROUP_ID" policies="editor" >/dev/null
    fi
    bao write -force identity/group-alias name="$G" mount_accessor="$ACCESSOR" canonical_id="$GROUP_ID" >/dev/null || true
    echo "   -> bound editor policy to OIDC group '$G'"
  done
fi

# CSV → reader
if [ -n "$OIDC_READONLY_GROUPS" ]; then
  echo "$OIDC_READONLY_GROUPS" | tr "," "\n" | while read -r G; do
    G="$(trim "$G")"; [ -z "$G" ] && continue
    GROUP_ID=$(bao read -format=json identity/group/name/"$G" 2>/dev/null | jq -r ".data.id // empty")
    if [ -z "$GROUP_ID" ]; then
      GROUP_ID=$(bao write -format=json identity/group name="$G" type="external" policies="reader" | jq -r ".data.id")
    else
      bao write identity/group id="$GROUP_ID" policies="reader" >/dev/null
    fi
    bao write -force identity/group-alias name="$G" mount_accessor="$ACCESSOR" canonical_id="$GROUP_ID" >/dev/null || true
    echo "   -> bound reader policy to OIDC group '$G'"
  done
fi

echo "   -> OIDC configured. Login via UI ($REDIRECT_UI) or CLI (bao login -method=oidc)."
'
  fi
fi

# ────────────────────────────────────────────────────────────────────────────────
# Print (and optionally apply) ClusterSecretStore
# ────────────────────────────────────────────────────────────────────────────────
STORE_YAML="$(cat <<EOF
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: ${STORE_NAME}
spec:
  provider:
    vault:
      server: http://${REL}.${NS}.svc:8200
      path: ${KV_PATH}
      version: v2
      auth:
        kubernetes:
          mountPath: kubernetes
          role: eso-syncer
          # serviceAccountRef:
          #   name: external-secrets
          #   namespace: ${ESO_NS}
EOF
)"
if [[ "${PRINT_STORE_SNIPPET}" == "1" ]]; then
  echo; echo "# --- ClusterSecretStore (copy to Git/Argo) ---"
  echo "$STORE_YAML"; echo "# --------------------------------------------"
fi
if [[ "${APPLY_STORE}" == "1" ]]; then
  echo "$STORE_YAML" | kubectl apply -f -
fi

# ────────────────────────────────────────────────────────────────────────────────
# Re-print keys if we initialized in this run
# ────────────────────────────────────────────────────────────────────────────────
if [[ -n "${UNSEAL_KEY:-}" || -n "${ROOT_TOKEN:-}" ]]; then
  echo; echo "==== COPY/STORE SECURELY ===="
  [[ -n "${UNSEAL_KEY:-}" ]] && echo "UNSEAL_KEY=${UNSEAL_KEY}"
  [[ -n "${ROOT_TOKEN:-}" ]] && echo "ROOT_TOKEN=${ROOT_TOKEN}"
  echo "============================="
fi

echo "==> Done."
