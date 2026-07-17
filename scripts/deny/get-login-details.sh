#!/usr/bin/env bash
set -euo pipefail

env_of() {
  kubectl get deployment boltmcp-web -n boltmcp \
    -o jsonpath="{.spec.template.spec.containers[0].env[?(@.name=='$1')].value}"
}

WEB_BASE_URL=$(env_of WEB_BASE_URL)
OIDC_ISSUER_URL=$(env_of OIDC_ISSUER_URL)
KEYCLOAK_BASE_URL=${OIDC_ISSUER_URL%/realms/boltmcp}

echo "BoltMCP dashboard:    ${WEB_BASE_URL}"
echo "BoltMCP docs:         ${WEB_BASE_URL}/docs"
echo "Keycloak admin:       ${KEYCLOAK_BASE_URL}/admin/boltmcp/console/"
echo "Username:             boltmcp_admin"
printf "Password:             "
kubectl get secret boltmcp-auth -n boltmcp \
  -o jsonpath='{.data.boltmcp-admin-password}' | base64 -d
echo
