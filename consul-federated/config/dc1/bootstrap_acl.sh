#!/bin/sh

export CONSUL_HTTP_ADDR=https://1.server.dc1.consul.container.shipyard.run:8501

# Wait for consul to elect a leader
until curl -s -k ${CONSUL_HTTP_ADDR}/v1/status/leader | grep 8300; do
  echo "Waiting for Consul to start"
  sleep 1
done

# Bootstrap the ACL And export the token
consul acl bootstrap -format=json | grep -o '"SecretID": "[^"]*' | grep -o '[^"]*$' > /output/token_dc1.txt

#CONSUL_HTTP_ADDR=https://1.server.dc2.consul.container.shipyard.run:8501 \
#  consul acl bootstrap -format=json | grep -o '"SecretID": "[^"]*' | grep -o '[^"]*$' > /output/token.txt

#CONSUL_HTTP_ADDR=https://1.server.dc2.consul.container.shipyard.run:8501 \
#CONSULT_HTTP_TOKEN=$(cat /output/token.txt) \