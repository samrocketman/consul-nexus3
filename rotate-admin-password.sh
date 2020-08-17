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

if docker-compose exec -T nexus3 [ -f /nexus-data/admin.password ]; then
  OLD_PASSWORD="$(docker-compose exec -T nexus3 cat /nexus-data/admin.password)"
else
  OLD_PASSWORD="$(execute_vault_command vault kv get -field=password docker/nexus-admin)"
fi

NEW_PASSWORD="$(random_password '-+=a-zA-Z.@%')"

docker-compose exec -T nexus3 curl -if \
  -u admin:"${OLD_PASSWORD}" \
  -XPUT -H 'Content-Type: text/plain' \
  --data "${NEW_PASSWORD}" \
  http://portal.service.consul/nexus/service/rest/v1/security/users/admin/change-password
  #http://portal.service.consul/nexus/service/rest/internal/ui/onboarding/change-admin-password
execute_vault_command vault kv put docker/nexus-admin user=admin password="${NEW_PASSWORD}"
