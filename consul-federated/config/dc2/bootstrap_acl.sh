#!/bin/sh

export CONSUL_HTTP_ADDR=https://1.server.dc2.consul.container.shipyard.run:8501
export CONSUL_HTTP_TOKEN=$(cat /output/token_dc1.txt)

until consul acl set-agent-token replication $(cat /output/token_replication.txt); do
  echo "Waiting for ACL Replication"
  sleep 1
done

consul acl set-agent-token agent $(cat /output/token_dc1.txt)