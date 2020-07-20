#!/bin/sh

export CONSUL_HTTP_ADDR=https://1.server.dc1.consul.container.shipyard.run:8501

# Wait for consul to elect a leader
until curl -s -k ${CONSUL_HTTP_ADDR}/v1/status/leader | grep 8300; do
  echo "Waiting for Consul to start"
  sleep 1
done

# Bootstrap the ACL And export the token
consul acl bootstrap -format=json | grep -o '"SecretID": "[^"]*' | grep -o '[^"]*$' > /output/token_dc1.txt

export CONSUL_HTTP_TOKEN=$(cat /output/token_dc1.txt)

# Write the replication policy
consul acl policy create -name replication -rules @/scripts/replication_policy.hcl

# Create a replication token
consul acl token create -description "replication token" -policy-name replication -format=json | grep -o '"SecretID": "[^"]*' | grep -o '[^"]*$' > /output/token_replication.txt

#CONSUL_HTTP_ADDR=https://1.server.dc2.consul.container.shipyard.run:8501 \
#  consul acl bootstrap -format=json | grep -o '"SecretID": "[^"]*' | grep -o '[^"]*$' > /output/token.txt

#CONSUL_HTTP_ADDR=https://1.server.dc2.consul.container.shipyard.run:8501 \
#CONSULT_HTTP_TOKEN=$(cat /output/token.txt) \