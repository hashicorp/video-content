nomad_job "web" {
  cluster = "nomad_cluster.dc1"
  paths = ["./nomad_jobs/web.hcl"]
}

nomad_job "prometheus" {
  cluster = "nomad_cluster.dc1"
  paths = ["./nomad_jobs/prometheus.hcl"]
}

nomad_job "api" {
  cluster = "nomad_cluster.dc1"
  paths = ["./nomad_jobs/api.hcl"]
}

nomad_job "autoscaler" {
  cluster = "nomad_cluster.dc1"
  paths = ["./nomad_jobs/autoscaler.hcl"]
}