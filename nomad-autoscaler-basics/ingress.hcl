container_ingress "consul-http" {
  target = "container.consul"

  network {
    name = "network.dc1"
  }

  port {
    local  = 8500
    remote = 8500
    host   = 8500
    open_in_browser = "/ui"
  }
  
  port {
    local  = 8300
    remote = 8300
  }
  
  port {
    local  = 8301
    remote = 8301
  }
  
  port {
    local  = 8302
    remote = 8302
  }
}

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
    open_in_browser = "/ui"
  }
}

nomad_ingress "web-http" {
  cluster  = "nomad_cluster.dc1"
  job = ""
  group = ""
  task = ""
  
  network {
    name = "network.dc1"
  }

  port {
    local  = 8080
    remote = 8080
    host   = 8080
  }
}