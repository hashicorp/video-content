#!/bin/sh

# Generate the CA
consul tls ca create -domain consul.container.shipyard.run

# Generate the node certs
consul tls cert create -server -node 1 -domain consul.container.shipyard.run -dc dc1 -additional-dnsname 1.server.dc1.consul.container.shipyard.run.server.dc1.consul -additional-dnsname server.dc1.consul -additional-dnsname 1.server.dc1.consul
consul tls cert create -server -node 1 -domain consul.container.shipyard.run -dc dc2 -additional-dnsname 1.server.dc2.consul.container.shipyard.run.server.dc2.consul -additional-dnsname server.dc2.consul -additional-dnsname 1.server.dc2.consul

mv *.pem /output