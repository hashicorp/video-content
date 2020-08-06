---
title: "Consul Multi-cluster"
author: "Nic Jackson"
slug: "consul-federated"
---

Consul Multi-cluster federated with Consul Gateways

Creates the following resources
* Network dc1 - Subnet: 10.5.0.0/16
* Network dc2 - Subnet: 10.6.0.0/16
* Network wan - Subnet: 10.7.0.0/16
* Consul Server dc1
* Mesh Gateway  dc1
* Consul Server dc2
* Mesh Gateway  dc2

The Consul servers have TLS and ACLS enabled and are federated together on the WAN network, the Consul UI can be accessed via 
the URL: https://1.server.dc1.consul.container.shipyard.run:18501

Consul is secured with TLS and ACL tokens, when opening the UI in your browser you will need to click the allow insecure button, the
CA which is used to secure Consul can be found in the file: $HOME/.shipyard/data/tls/consul.container.shipyard.run-agent-ca.pem

To access the UI or to interact with the CLI you will need an ACL token, the bootstrap ACL token can be found in the file: 
$HOME/.shipyard/data/tokens/token_dc1.txt
