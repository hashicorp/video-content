
container "1.server.dc2.consul" {
  depends_on = ["exec_remote.bootstrap_certs"]

  image {
    name = "consul:1.8.0"
  }
  
  command = [
    "consul", 
    "agent", 
    "-node=1",
    "-config-file=/etc/consul/config/consul.hcl"
  ]
  
  volume {
    source      = "./config/dc2"
    destination = "/etc/consul/config"
  }
  
  volume {
    source      = "${data("tls")}"
    destination = "/etc/consul/tls"
  }

  network { 
    name = "network.dc2"
  }
  
  network {
    name = "network.wan"
  }
  
  port {
    local  = 8501
    remote = 8501
    host   = 18601
  }
}

exec_remote "bootstrap_acl_dc2" {
  depends_on = ["container.1.server.dc2.consul", "exec_remote.bootstrap_acl_dc1"]

  image   {
    name = "nicholasjackson/consul-envoy:v1.8.0-v1.12.4"
  }
  
  network {
    name = "network.dc1"
  }
  
  network {
    name = "network.dc2"
  }

  env {
    key = "CONSUL_CACERT"
    value = "/etc/consul/tls/consul.container.shipyard.run-agent-ca.pem"
  }

  cmd = "/scripts/bootstrap_acl.sh"
  
  volume {
    source      = "./config/dc2"
    destination = "/scripts"
  }
  
  volume {
    source      = "${data("tls")}"
    destination = "/etc/consul/tls"
  }
  
  volume {
    source      = "${data("tokens")}"
    destination = "/output"
  }
}

container "gateway.dc2.consul" {
  depends_on = ["exec_remote.bootstrap_acl_dc2"]

  image   {
    name = "nicholasjackson/consul-envoy:v1.8.0-v1.12.4"
  }

  # The following command start a Consul Connect gateway
  command = [
      "/bin/sh", "-c",
<<EOF
consul connect envoy \
-mesh-gateway \
-token $(cat /token_dc1.txt) \
-register \
-expose-servers \
-address '10.6.0.203:443' \
-wan-address '10.7.0.203:443' \
-- -l debug
EOF
      ]

  network {
    name = "network.dc2"
    ip_address = "10.6.0.203"
  }
  
  network {
    name = "network.wan"
    ip_address = "10.7.0.203"
  }

  # This container does not have a local agent so we are registering the gateway 
  # direct with the server 
  env_var =  {
    CONSUL_HTTP_ADDR = "https://1.server.dc2.consul.container.shipyard.run:8501"
    CONSUL_GRPC_ADDR = "1.server.dc2.consul.container.shipyard.run:8502"
    CONSUL_CACERT = "/etc/consul/tls/consul.container.shipyard.run-agent-ca.pem"
  }
  
  volume {
    source      = "${data("tls")}"
    destination = "/etc/consul/tls"
  }
  
  volume {
    source = "${data("tokens")}/token_dc1.txt"
    destination      = "/token_dc1.txt"
  }
}