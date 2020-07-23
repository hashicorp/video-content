nomad_ingress "nomad-http" {
  cluster  = "nomad_cluster.dc1"
  job = ""
  group = ""
  task = ""
  
  network {
    name = "network.dc1"
  }

  port {
    local  = 4646
    remote = 4646
    host   = 4646
  }
}