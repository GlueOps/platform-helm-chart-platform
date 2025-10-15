#!/usr/bin/env bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────────────────────
# Help / Usage
# ────────────────────────────────────────────────────────────────────────────────
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || "${HELP:-}" == "1" ]]; then
  cat <<'USAGE'
OpenBao Bootstrap (install, init, unseal, TLS for nodes, ESO + OIDC wiring)

Prereqs:
  - kubectl, helm, jq in PATH
  - Kubernetes access to your cluster
  - cert-manager installed (your controllers are in glueops-core-cert-manager)
  - (Optional) Dex client for OIDC: client_id + client_secret

What this script does:
  1) Uninstalls an old Bao release + cleans PVC/PV finalizers.
  2) (TLS) Creates a self-signed CA + node certificate (or uses your Issuer).
  3) Installs Bao via Helm with node TLS enabled (pods mount /tls).
  4) Initializes Bao (prints UNSEAL_KEY + ROOT_TOKEN) if needed.
  5) Unseals leader, joins followers to raft, unseals followers.
  6) (Optional) Configures ESO (Kubernetes auth + least-priv policy/role).
  7) (Optional) Configures OIDC (Dex) + binds groups → editor/reader policies.
  8) Prints (optionally applies) a ClusterSecretStore pointing at Bao.
     If TLS is on, it uses https:// and provides the CA bundle to ESO.

Required (typical):
  export BAO_PUBLIC_URL="https://openbao.nonprod.earth.onglueops.rocks"

  # OIDC with Dex (if ENABLE_OIDC=1)
  export OIDC_CLIENT_ID="openbao"
  export OIDC_CLIENT_SECRET="REDACTED"
  export OIDC_DISCOVERY_URL="https://dex.nonprod.earth.onglueops.rocks"

Strongly recommended:
  # Bind Dex groups to Bao policies:
  export OIDC_ADMIN_GROUPS="my-org:platform-editors"                               # → editor policy
  export OIDC_READONLY_GROUPS="glueops-rocks:super_admins,development-tenant-earth:developers"  # → reader policy

TLS controls (defaults shown):
  export ENABLE_TLS="1"                       # 1=enable node TLS, 0=off
  export TLS_INTERNAL_MODE="selfsigned"      # selfsigned | reference
  export TLS_SECRET_NAME="openbao-tls"       # Secret mounted by Bao pods
  # If TLS_INTERNAL_MODE=reference, set the issuer to use:
  # export TLS_ISSUER_KIND="ClusterIssuer"
  # export TLS_ISSUER_NAME="letsencrypt-prod"

  # Ingress TLS (off by default). If enabled, a cert for BAO_PUBLIC_URL host is issued.
  export TLS_INGRESS_ENABLE="0"
  # If enabled and using your issuer:
  # export TLS_INGRESS_ISSUER_KIND="ClusterIssuer"
  # export TLS_INGRESS_ISSUER_NAME="letsencrypt-prod"
  export TLS_INGRESS_SECRET="openbao-ingress-tls"

Other useful env (defaults shown):
  export NS="glueops-core-boa"                      # Bao namespace
  export REL="openbao"                              # Helm release name
  export VALUES_FILE="values-openbao.yaml"          # Helm values file
  # export CHART_VERSION=""                         # empty = latest repo

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

OIDC toggles (defaults shown):
  export ENABLE_OIDC="1"
  export OIDC_DISCOVERY_URL="https://dex.nonprod.earth.onglueops.rocks"
  export BAO_PUBLIC_URL="https://openbao.nonprod.earth.onglueops.rocks"
  export OIDC_CLIENT_ID=""           # REQUIRED if ENABLE_OIDC=1
  export OIDC_CLIENT_SECRET=""       # REQUIRED if ENABLE_OIDC=1
  export OIDC_ADMIN_GROUPS=""        # csv -> editor policy
  export OIDC_READONLY_GROUPS=""     # csv -> reader policy
  # legacy singles (merged into CSV if set)
  export OIDC_ADMIN_GROUP=""
  export OIDC_READONLY_GROUP=""

Examples:

  # End-to-end with node TLS (selfsigned), OIDC groups and ESO:
  export OIDC_CLIENT_ID=openbao
  export OIDC_CLIENT_SECRET=REDACTED
  export OIDC_ADMIN_GROUPS='my-org:platform-editors'
  export OIDC_READONLY_GROUPS='glueops-rocks:super_admins,development-tenant-earth:developers'
  ./bootstrap-openbao-full.sh

  # Use your ClusterIssuer for node TLS and enable ingress TLS:
  TLS_INTERNAL_MODE=reference TLS_ISSUER_KIND=ClusterIssuer TLS_ISSUER_NAME=letsencrypt-prod \
  TLS_INGRESS_ENABLE=1 TLS_INGRESS_ISSUER_KIND=ClusterIssuer TLS_INGRESS_ISSUER_NAME=letsencrypt-prod \
  ./bootstrap-openbao-full.sh

Notes:
  - Script prints UNSEAL_KEY and ROOT_TOKEN on a fresh init. Handle securely.
  - For OIDC CLI login, use: bao login -method=oidc -path=oidc
  - Dex groups must match the "groups" claim (often "org:team").
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

# ----- TLS (cert-manager) -----
ENABLE_TLS="${ENABLE_TLS:-1}"
TLS_INTERNAL_MODE="${TLS_INTERNAL_MODE:-selfsigned}"      # selfsigned | reference
TLS_SECRET_NAME="${TLS_SECRET_NAME:-openbao-tls}"

TLS_ISSUER_KIND="${TLS_ISSUER_KIND:-ClusterIssuer}"       # used if MODE=reference
TLS_ISSUER_NAME="${TLS_ISSUER_NAME:-}"

TLS_INGRESS_ENABLE="${TLS_INGRESS_ENABLE:-0}"
TLS_INGRESS_ISSUER_KIND="${TLS_INGRESS_ISSUER_KIND:-${TLS_ISSUER_KIND}}"
TLS_INGRESS_ISSUER_NAME="${TLS_INGRESS_ISSUER_NAME:-${TLS_ISSUER_NAME}}"
TLS_INGRESS_SECRET="${TLS_INGRESS_SECRET:-openbao-ingress-tls}"

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

# Ensure namespace exists early (needed for certs)
kubectl get ns "$NS" >/dev/null 2>&1 || kubectl create ns "$NS"

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
# TLS: issue internal node certificate (and optional ingress cert)
# ────────────────────────────────────────────────────────────────────────────────
TLS_VALUES_FILE=""
BAO_PUBLIC_HOST="$(echo "$BAO_PUBLIC_URL" | sed -E 's~^https?://([^/]+)/?.*$~\1~')"

if [[ "$ENABLE_TLS" == "1" ]]; then
  echo "==> Preparing cert-manager TLS for nodes (secret: $TLS_SECRET_NAME)…"

  # Internal DNS SANs for Bao services and pods
  read -r -d '' DNS_JSON <<EOF || true
[
  "$REL.$NS.svc",
  "$REL.$NS.svc.cluster.local",
  "$REL-active.$NS.svc",
  "$REL-standby.$NS.svc",
  "$REL-internal.$NS.svc",
  "*.$REL-internal.$NS.svc",
  "$REL"
]
EOF

  # Create issuers/certs
  if [[ "$TLS_INTERNAL_MODE" == "selfsigned" ]]; then
    # Self-signed CA -> namespaced CA Issuer -> node cert
    cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: ${REL}-selfsigned
  namespace: ${NS}
spec:
  selfSigned: {}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ${REL}-ca
  namespace: ${NS}
spec:
  isCA: true
  commonName: ${REL}-ca
  secretName: ${REL}-ca
  privateKey:
    algorithm: RSA
    size: 2048
  issuerRef:
    name: ${REL}-selfsigned
    kind: Issuer
---
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: ${REL}-ca-issuer
  namespace: ${NS}
spec:
  ca:
    secretName: ${REL}-ca
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ${REL}-nodes
  namespace: ${NS}
spec:
  secretName: ${TLS_SECRET_NAME}
  privateKey:
    algorithm: RSA
    size: 2048
  usages: ["server auth","client auth"]
  dnsNames: $(echo "$DNS_JSON")
  issuerRef:
    name: ${REL}-ca-issuer
    kind: Issuer
EOF
  else
    if [[ -z "$TLS_ISSUER_NAME" ]]; then
      echo "!! TLS_INTERNAL_MODE=reference but TLS_ISSUER_NAME not set"; exit 1
    fi
    cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ${REL}-nodes
  namespace: ${NS}
spec:
  secretName: ${TLS_SECRET_NAME}
  privateKey:
    algorithm: RSA
    size: 2048
  usages: ["server auth","client auth"]
  dnsNames: $(echo "$DNS_JSON")
  issuerRef:
    name: ${TLS_ISSUER_NAME}
    kind: ${TLS_ISSUER_KIND}
EOF
  fi

  echo "==> Waiting for node certificate to be Ready..."
  kubectl -n "$NS" wait --for=condition=Ready certificate "${REL}-nodes" --timeout=180s
  kubectl -n "$NS" get secret "$TLS_SECRET_NAME" >/dev/null

  # Optional: ingress TLS
  if [[ "${TLS_INGRESS_ENABLE}" == "1" && -n "$BAO_PUBLIC_HOST" ]]; then
    echo "==> Issuing ingress TLS for ${BAO_PUBLIC_HOST} (secret: ${TLS_INGRESS_SECRET})"
    if [[ -n "$TLS_INGRESS_ISSUER_NAME" ]]; then
      cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ${REL}-ingress
  namespace: ${NS}
spec:
  secretName: ${TLS_INGRESS_SECRET}
  dnsNames:
    - ${BAO_PUBLIC_HOST}
  issuerRef:
    name: ${TLS_INGRESS_ISSUER_NAME}
    kind: ${TLS_INGRESS_ISSUER_KIND}
EOF
    else
      # Fall back to internal CA (browser will warn)
      cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ${REL}-ingress
  namespace: ${NS}
spec:
  secretName: ${TLS_INGRESS_SECRET}
  dnsNames:
    - ${BAO_PUBLIC_HOST}
  issuerRef:
    name: ${REL}-ca-issuer
    kind: Issuer
EOF
    fi
    kubectl -n "$NS" wait --for=condition=Ready certificate "${REL}-ingress" --timeout=180s
  fi

  # Create a small values overlay to mount TLS secret + enable TLS listener
  TLS_VALUES_FILE="$(mktemp)"
  {
    echo "server:"
    echo "  extraVolumes:"
    echo "    - name: tls"
    echo "      secret:"
    echo "        secretName: ${TLS_SECRET_NAME}"
    echo "  extraVolumeMounts:"
    echo "    - name: tls"
    echo "      mountPath: /tls"
    echo "      readOnly: true"
    echo "  ha:"
    echo "    extraConfig: |"
    echo "      listener \"tcp\" {"
    echo "        address          = \"0.0.0.0:8200\""
    echo "        cluster_address  = \"0.0.0.0:8201\""
    echo "        tls_disable      = 0"
    echo "        tls_cert_file    = \"/tls/tls.crt\""
    echo "        tls_key_file     = \"/tls/tls.key\""
    echo "        tls_client_ca_file = \"/tls/ca.crt\""
    echo "      }"
    # Optionally wire ingress TLS if enabled
    if [[ "${TLS_INGRESS_ENABLE}" == "1" && -n "$BAO_PUBLIC_HOST" ]]; then
      cat <<EOF2
  ingress:
    tls:
      - secretName: ${TLS_INGRESS_SECRET}
        hosts:
          - ${BAO_PUBLIC_HOST}
EOF2
    fi
  } >"$TLS_VALUES_FILE"
fi

# ────────────────────────────────────────────────────────────────────────────────
# Fresh install via Helm (after TLS secret exists, so pods come up cleanly)
# ────────────────────────────────────────────────────────────────────────────────
echo "==> Adding/updating Helm repo…"
helm repo add openbao https://openbao.github.io/openbao-helm >/dev/null 2>&1 || true
helm repo update >/dev/null

echo "==> Installing OpenBao…"
set -x
helm upgrade --install "$REL" openbao/openbao \
  -n "$NS" \
  -f "$VALUES_FILE" \
  ${TLS_VALUES_FILE:+ -f "$TLS_VALUES_FILE"} \
  ${CHART_VERSION:+--version "$CHART_VERSION"} \
  --wait --timeout 10m
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
  kubectl -n "$NS" exec "$POD" -- bao operator raft join "https://${REL}-0.${REL}-internal:8201" >/dev/null 2>&1 || \
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
# If TLS enabled, use https and provide CA bundle to ESO
if [[ "${ENABLE_TLS}" == "1" ]]; then
  CA_PROVIDER_SNIPPET=$(cat <<EOF
      caProvider:
        type: Secret
        name: ${TLS_SECRET_NAME}
        key: ca.crt
        namespace: ${NS}
EOF
)
  SERVER_SCHEME="https"
else
  CA_PROVIDER_SNIPPET=""
  SERVER_SCHEME="http"
fi

STORE_YAML="$(cat <<EOF
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: ${STORE_NAME}
spec:
  provider:
    vault:
      server: ${SERVER_SCHEME}://${REL}.${NS}.svc:8200
      path: ${KV_PATH}
      version: v2
${CA_PROVIDER_SNIPPET}
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
