#!/bin/bash

function wait_for_healthy() {
  local count=0
  while ! docker-compose exec -T  nexus3 \
    curl -sSfIo /dev/null http://localhost:8081/nexus/service/rest/v1/status; do
    (( count=count+1  ))
    if [ "${count}" -gt 300  ]; then
      echo 'ERROR: Nexus was not healthy after 300 seconds.'
      exit  1
    fi
    sleep 1
  done
}

set -e

wait_for_healthy

source ~/git/github/docker-compose-ha-consul-vault-ui/scripts/vault-functions.sh
set_vault_infra_token
trap 'revoke_self' EXIT

echo Nexus user: admin
echo "Nexus password: $(execute_vault_command vault kv get -field=password docker/nexus-admin)"
