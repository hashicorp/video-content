---
title: "Consul Multi-cluster"
author: "Nic Jackson"
slug: "consul-federated"
env:
- CONSUL_HTTP_ADDR=https://localhost:18501
- CONSUL_CACERT=./config/tls/consul.container.shipyard.run-agent-ca.pem
---

Consul Multi-cluster federated with Consul Gateways