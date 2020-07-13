container "consul" {
  image   {
    name = "consul:1.8.0"
  }

  command = ["consul", "agent", "-config-file=/config/server.hcl"]

  volume {
    source      = "./consul_config/server.hcl"
    destination = "/config/server.hcl"
  }

  network {
    name = "network.dc1"
  }
}