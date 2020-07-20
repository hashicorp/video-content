#!/bin/sh

export CONSUL_HTTP_ADDR=https://1.server.dc2.consul.container.shipyard.run:8501

until curl -s -k ${CONSUL_HTTP_ADDR}/v1/status/leader | grep 8300; do
  echo "Waiting for Consul to start"
  sleep 1
done

consul acl bootstrap -format=json | grep -o '"SecretID": "[^"]*' | grep -o '[^"]*$' > /output/token_dc2.txt
export CONSUL_HTTP_TOKEN=$(cat /output/token_dc2.txt)

consul acl set-agent-token replication $(cat /output/token_dc1.txt)
consul acl set-agent-token agent $(cat /output/token_dc1.txt)
