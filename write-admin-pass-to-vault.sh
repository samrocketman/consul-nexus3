#!/bin/bash

set -e

NEXUS_PASSWORD="$(docker-compose exec -T nexus3 cat /nexus-data/admin.password)"
source ~/git/github/docker-compose-ha-consul-vault-ui/scripts/vault-functions.sh
set_vault_infra_token
execute_vault_command vault kv put docker/nexus-admin user=admin password="${NEXUS_PASSWORD}"
revoke_self
