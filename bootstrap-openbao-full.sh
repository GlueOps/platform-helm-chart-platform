#!/usr/bin/env bash
set -euo pipefail

# =======================
# Config (override via env)
# =======================
NS="${NS:-glueops-core-boa}"                 # OpenBao namespace
REL="${REL:-openbao}"                        # Helm release name
VALUES_FILE="${VALUES_FILE:-values-openbao.yaml}"

# Helm chart version (optional; empty = repo latest)
CHART_VERSION="${CHART_VERSION:-}"

# Init shares/threshold
SHARES="${SHARES:-1}"
THRESHOLD="${THRESHOLD:-1}"

# ESO wiring
CONFIGURE_ESO="${CONFIGURE_ESO:-1}"          # 1 = configure Kubernetes auth/policy/role for ESO
ESO_NS="${ESO_NS:-glueops-core-external-secrets}"
ESO_SA="${ESO_SA:-}"                         # auto-detected if empty
EXTRA_ESO_SAS="${EXTRA_ESO_SAS:-external-secrets-read-all-from-vault}"  # csv of extra SAs

# KV mount to use
KV_PATH="${KV_PATH:-kv}"

# Seed a demo secret?
SEED_DEMO="${SEED_DEMO:-1}"

# Print (and optionally apply) a ClusterSecretStore pointing at Bao’s internal service
PRINT_STORE_SNIPPET="${PRINT_STORE_SNIPPET:-1}"
APPLY_STORE="${APPLY_STORE:-0}"              # usually 0 (Argo manages it)
STORE_NAME="${STORE_NAME:-vault-backend}"    # reuse your consolidated store name

# =======================
# Pre-flight
# =======================
command -v kubectl >/dev/null || { echo "kubectl not found"; exit 1; }
command -v jq >/dev/null || { echo "jq not found (please install jq)"; exit 1; }

echo "==> OpenBao full bootstrap: NS=$NS REL=$REL VALUES=$VALUES_FILE"

# =======================
# Nuke old install (your steps)
# =======================
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

# =======================
# Fresh install via Helm
# =======================
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

# =======================
# Wait for pods to be Running (they'll be 0/1 while sealed)
# =======================
REPLICAS="$(kubectl -n "$NS" get sts "$REL" -o jsonpath='{.spec.replicas}')"
echo "==> Waiting for $REPLICAS pods to be in phase=Running…"
for (( i=0; i<REPLICAS; i++ )); do
  POD="${REL}-${i}"
  until [[ "$(kubectl -n "$NS" get pod "$POD" -o jsonpath='{.status.phase}' 2>/dev/null || echo pending)" == "Running" ]]; do
    sleep 2
  done
done

LEADER="${REL}-0"

# ===== helper funcs using JSON status (robust) =====
bao_status_json() {
  kubectl -n "$NS" exec "$1" -- sh -lc 'bao status -format=json || true' 2>/dev/null
}
wait_status_json() {
  local pod="$1"
  for _ in $(seq 1 60); do
    local js
    js="$(bao_status_json "$pod")"
    if [[ -n "$js" ]] && jq -e . >/dev/null 2>&1 <<<"$js"; then
      echo "$js"
      return 0
    fi
    sleep 2
  done
  return 1
}
is_initialized() {
  local js
  js="$(wait_status_json "$LEADER" || echo '')"
  if [[ -z "$js" ]]; then echo "false"; return; fi
  jq -r '.initialized // false' <<<"$js"
}
is_sealed_pod() {
  local pod="$1"
  local js
  js="$(bao_status_json "$pod")"
  # IMPORTANT FIX: default to false if field missing
  jq -r '.sealed // false' <<<"$js"
}

# =======================
# Initialize (print UNSEAL_KEY + ROOT_TOKEN)
# =======================
if [[ "$(is_initialized)" == "true" ]]; then
  echo "==> Bao already initialized."
else
  echo "==> Initializing Bao (shares=$SHARES threshold=$THRESHOLD)…"
  INIT_JSON="$(kubectl -n "$NS" exec "$LEADER" -- \
    bao operator init -key-shares="$SHARES" -key-threshold="$THRESHOLD" -format=json )"

  UNSEAL_KEY="$(jq -r '.unseal_keys_b64[0]' <<<"$INIT_JSON")"
  ROOT_TOKEN="$(jq -r '.root_token' <<<"$INIT_JSON")"

  if [[ -z "$UNSEAL_KEY" || -z "$ROOT_TOKEN" || "$UNSEAL_KEY" == "null" || "$ROOT_TOKEN" == "null" ]]; then
    echo "!! Failed to parse init output:"
    echo "$INIT_JSON"
    exit 1
  fi

  echo
  echo "================= OPENBAO INIT OUTPUT ================="
  echo "UNSEAL_KEY=${UNSEAL_KEY}"
  echo "ROOT_TOKEN=${ROOT_TOKEN}"
  echo "======================================================="
  echo
  export UNSEAL_KEY ROOT_TOKEN
fi

# =======================
# Unseal leader BEFORE any raft join
# =======================
if [[ -n "${UNSEAL_KEY:-}" && "$(is_sealed_pod "$LEADER")" == "true" ]]; then
  echo "==> Unsealing leader: $LEADER"
  kubectl -n "$NS" exec "$LEADER" -- bao operator unseal "$UNSEAL_KEY" >/dev/null
fi

# =======================
# Join + unseal followers
# =======================
for (( i=1; i<REPLICAS; i++ )); do
  POD="${REL}-${i}"
  echo "==> Ensuring raft join for: $POD"
  kubectl -n "$NS" exec "$POD" -- \
    bao operator raft join "http://${REL}-0.${REL}-internal:8200" >/dev/null 2>&1 || true

  if [[ -n "${UNSEAL_KEY:-}" && "$(is_sealed_pod "$POD")" == "true" ]]; then
    echo "==> Unsealing follower: $POD"
    kubectl -n "$NS" exec "$POD" -- bao operator unseal "$UNSEAL_KEY" >/dev/null || true
  fi
done

echo "==> Cluster pods:"
kubectl -n "$NS" get pods -l app.kubernetes.io/instance="$REL" -o wide
echo "==> Bao status (leader):"
kubectl -n "$NS" exec "$LEADER" -- sh -lc 'bao status || true'

# =======================
# Configure for ESO (Kubernetes auth + policy + role)
# =======================
if [[ "${CONFIGURE_ESO}" == "1" ]]; then
  if [[ "$(is_sealed_pod "$LEADER")" == "true" ]]; then
    echo "!! Bao is sealed; skipping ESO config. Unseal and re-run."
    exit 1
  fi

  echo "==> Configuring Bao for External Secrets…"
  if [[ -z "$ESO_SA" ]]; then
    ESO_SA="$(kubectl -n "$ESO_NS" get deploy -l app.kubernetes.io/name=external-secrets \
      -o jsonpath='{.items[0].spec.template.spec.serviceAccountName}')"
  fi
  [[ -z "$ESO_SA" ]] && { echo "!! Could not detect ESO SA in $ESO_NS"; exit 1; }

  AUTH_SAS="$ESO_SA"
  [[ -n "$EXTRA_ESO_SAS" ]] && AUTH_SAS="$AUTH_SAS,$EXTRA_ESO_SAS"
  AUTH_SAS="$(echo "$AUTH_SAS" | sed 's/,,*/,/g;s/^,\|,$//g')"

  kubectl -n "$NS" exec "$LEADER" -- env \
    KV_PATH="$KV_PATH" ESO_NS="$ESO_NS" AUTH_SAS="$AUTH_SAS" ROOT_TOKEN="${ROOT_TOKEN:-}" sh -lc '
set -e
# login non-interactively if ROOT_TOKEN present; else rely on prior init/login
if [ -n "$ROOT_TOKEN" ]; then bao login "$ROOT_TOKEN" >/dev/null; fi

# ensure kv v2 at $KV_PATH
if ! bao secrets list -format=json | jq -e ".[\"$KV_PATH/\"]" >/dev/null; then
  bao secrets enable -path="$KV_PATH" kv-v2
fi

# enable & configure Kubernetes auth (idempotent)
bao auth enable kubernetes >/dev/null 2>&1 || true
bao write auth/kubernetes/config \
  token_reviewer_jwt=@/var/run/secrets/kubernetes.io/serviceaccount/token \
  kubernetes_host="https://kubernetes.default.svc:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt >/dev/null

# least-priv policy
cat >/tmp/eso-read.hcl <<EOF
path "'"$KV_PATH"'/data/apps/*"       { capabilities = ["read"] }
path "'"$KV_PATH"'/metadata/apps/*"   { capabilities = ["list","read"] }
EOF
bao policy write eso-read /tmp/eso-read.hcl >/dev/null

# role binding (can include multiple SAs)
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

# =======================
# Print (and optionally apply) ClusterSecretStore
# =======================
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
          # serviceAccountRef:   # usually omit so ESO uses its own SA token
          #   name: external-secrets
          #   namespace: ${ESO_NS}
EOF
)"
if [[ "${PRINT_STORE_SNIPPET}" == "1" ]]; then
  echo
  echo "# --- ClusterSecretStore (copy to Git/Argo) ---"
  echo "$STORE_YAML"
  echo "# --------------------------------------------"
fi
if [[ "${APPLY_STORE}" == "1" ]]; then
  echo "$STORE_YAML" | kubectl apply -f -
fi

# =======================
# Re-print keys if we initialized in this run
# =======================
if [[ -n "${UNSEAL_KEY:-}" || -n "${ROOT_TOKEN:-}" ]]; then
  echo
  echo "==== COPY/STORE SECURELY ===="
  [[ -n "${UNSEAL_KEY:-}" ]] && echo "UNSEAL_KEY=${UNSEAL_KEY}"
  [[ -n "${ROOT_TOKEN:-}" ]] && echo "ROOT_TOKEN=${ROOT_TOKEN}"
  echo "============================="
fi

echo "==> Done."
