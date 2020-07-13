nomad_cluster "dc1" {
  version = "v0.11.2"

  nodes = 1

  network {
    name = "network.dc1"
    ip_address = "10.10.0.100"
  }

  volume {
      source = "./nomad_config/server.hcl"
      destination = "/etc/nomad.d/config.hcl"
  }
}