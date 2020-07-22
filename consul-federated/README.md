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

The Consul servers have TLS and ACLS enabled and are federated together on the WAN network.