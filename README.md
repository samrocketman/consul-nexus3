# Consul Nexus 3

This demo shows an example of Nexus 3 using consul for service discovery.

This is a companion project for
https://github.com/samrocketman/docker-compose-ha-consul-vault-ui


# Quickstart

# Start the dependent cluster

This assumes you have cloned this repository and
docker-compose-ha-consul-vault-ui to `${HOME}/git/github`.

docker-compose-ha-consul-vault-ui must be started before this project and be
healthy.  Your browser should be configured for SOCKS according to the README so
that you can visit the Vault and Nexus UI.

# Start the service

    docker-compose up -d
    ./rotate-admin-password.sh

# Get the admin password

Execute the script to display Nexus admin credentials.

    ./display_admin_password.sh

# Log into web UI

Visit Nexus UI [the portal](http://portal.service.consul/) and click on the link
for `Nexus 3` which should lead you to http://portal.service.consul/nexus/.

# License

[ASL v2](LICENSE)

```
Copyright (c) 2018-2020 Sam Gleske - https://github.com/samrocketman/docker-compose-local-nexus3-proxy

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
