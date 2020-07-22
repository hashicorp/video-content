output "CONSUL_HTTP_ADDR" {
  value = "https://1.server.dc1.consul.container.shipyard.run:18501"
}

output "CONSUL_CACERT" {
  value = "${data("tls")}/consul.container.shipyard.run-agent-ca.pem"
}

output "CONSUL_HTTP_TOKEN" {
  value ="$(cat ${data("tokens")}/token_dc1.txt)"
}