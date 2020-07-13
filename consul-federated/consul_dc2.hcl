network "dc2" {
  subnet = "10.6.0.0/16"
}

container "1.server.dc2.consul" {
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
    source      = "./config/tls"
    destination = "/etc/consul/tls"
  }

  network { 
    name = "network.dc2"
  }
  
  network {
    name = "network.wan"
  }
}


container "gateway.dc2.consul" {
  image   {
    name = "nicholasjackson/consul-envoy:v1.8.0-v1.12.4"
  }

  # The following command start a Consul Connect gateway
  command = [
      "consul",
      "connect", "envoy",
      "-mesh-gateway",
      "-register",
      "-expose-servers",
      "-address", "10.6.0.203:443",
      "-wan-address", "10.7.0.203:443",
      "--",
      "-l", "debug"]

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
  env {
    key = "CONSUL_HTTP_ADDR" 
    value = "https://1.server.dc2.consul.container.shipyard.run:8501"
  }

  env {
    key = "CONSUL_GRPC_ADDR"
    value = "1.server.dc2.consul.container.shipyard.run:8502"
  }
  env {
    key = "CONSUL_CACERT"
    value = "/etc/consul/tls/consul.container.shipyard.run-agent-ca.pem"
  }
  
  volume {
    source      = "./config/tls"
    destination = "/etc/consul/tls"
  }
}