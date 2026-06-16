#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ] || [ -z "$1" ]; then
  echo "Usage: $0 <GLOBAL_DOMAIN>" >&2
  echo "Please provide your global.domain, e.g. boltmcp.example.com" >&2
  exit 1
fi

GLOBAL_DOMAIN=$1

echo "BoltMCP dashboard:    https://web.${GLOBAL_DOMAIN}"
echo "BoltMCP docs:         https://web.${GLOBAL_DOMAIN}/docs"
echo "Keycloak admin:       https://auth.${GLOBAL_DOMAIN}/admin/boltmcp/console/"
echo "Username:             boltmcp_admin"
printf "Password:             "
kubectl get secret boltmcp-auth -n boltmcp \
  -o jsonpath='{.data.boltmcp-admin-password}' | base64 -d
echo
