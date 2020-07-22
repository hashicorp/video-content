#!/bin/sh -e

# Wait for consul to start
until curl -k -s https://${CONSUL_SERVER}:8501/v1/status/leader | grep 8300; do
  echo "Waiting for Consul to start"
  sleep 1
done

# Login to consul using a JWT
CONSUL_HTTP_ADDR=https://${CONSUL_SERVER}:8501 consul login -method my-jwt -bearer-token-file /config/jwt.token -token-sink-file /consul.token

# refresh the token for the consul agent
consul acl set-agent-token -token-file /consul.token default $(cat /consul.token)