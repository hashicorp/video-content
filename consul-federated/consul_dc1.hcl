network "dc1" {
  subnet = "10.5.0.0/16"
}

container "1.server.dc1.consul" {
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
    source      = "./config/dc1"
    destination = "/etc/consul/config"
  }
  
  volume {
    source      = "./config/tls"
    destination = "/etc/consul/tls"
  }

  network { 
    name = "network.dc1"
  }
  
  network {
    name = "network.wan"
  }

  port {
    local  = 8501
    remote = 8501
    host   = 18501
  }
}

container "gateway.dc1.consul" {
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
      "-address", "10.5.0.202:443",
      "-wan-address", "10.7.0.202:443",
      "--",
      "-l", "debug"]

  network {
    name = "network.dc1"
    ip_address = "10.5.0.202"
  }
  
  network {
    name = "network.wan"
    ip_address = "10.7.0.202"
  }

  # This container does not have a local agent so we are registering the gateway 
  # direct with the server 
  env {
    key = "CONSUL_HTTP_ADDR" 
    value = "https://1.server.dc1.consul.container.shipyard.run:8501"
  }

  env {
    key = "CONSUL_GRPC_ADDR"
    value = "1.server.dc1.consul.container.shipyard.run:8502"
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