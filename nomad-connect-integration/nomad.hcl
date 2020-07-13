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

  volume {
      source = "./consul_config/client.hcl"
      destination = "/config/client.hcl"
  }

  # Cached images to speed up the demo.
  image {
      name = "consul:1.8.0"
  }

  image {
      name = "nicholasjackson/fake-service:v0.9.0"
  }

  image {
      name = "nicholasjackson/consul-envoy:v1.8.0-v1.12.4"
  }
}