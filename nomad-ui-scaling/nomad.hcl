nomad_cluster "dc1" {
  version = "v0.12.0"

  network {
    name = "network.dc1"
  }

  image {
    name = "nicholasjackson/fake-service:v0.14.1"
  }
}