nomad_cluster "dc1" {
  version = "v0.11.2"

  nodes = 1

  network {
    name = "network.dc1"
    ip_address = "10.10.0.100"
  }

  network {
      name = "network.wan"
      ip_address = "192.168.10.100"
  }

  volume {
      source = "./nomad_config/server_dc1.hcl"
      destination = "/etc/nomad.d/config.hcl"
  }
  
  # Cached images to speed up the demo.
  image {
      name = "nicholasjackson/fake-service:v0.9.0"
  }
}

nomad_cluster "dc2" {
  version = "v0.11.2"

  nodes = 1

  network {
    name = "network.dc2"
    ip_address = "10.5.0.100"
  }

  network {
      name = "network.wan"
      ip_address = "192.168.5.100"
  }

  volume {
      source = "./nomad_config/server_dc2.hcl"
      destination = "/etc/nomad.d/config.hcl"
  }

  # Cached images to speed up the demo.
  image {
      name = "nicholasjackson/fake-service:v0.9.0"
  }
}