job "prometheus" {
    datacenters = ["dc1"]

    group "prometheus" {
        count = 1

        network {
            mode = "bridge"

            port "http" {
                static = 9090
                to = 9090
            }
        }

        task "prometheus" {
            template {
                destination = "local/prometheus.yml"
                data = <<EOH
---
global:
  scrape_interval: 1s
  evaluation_interval: 1s
scrape_configs:
  - job_name: nomad
    metrics_path: /v1/metrics
    params:
      format: ['prometheus']
    static_configs:
    - targets: ['{{ env "attr.unique.network.ip-address" }}:4646']
EOH
            }

            driver = "docker"

            config {
                image = "prom/prometheus:latest"
                volumes = [
                "local/prometheus.yml:/etc/prometheus/prometheus.yml",
                ]
            }

            resources {
                cpu = 100
                memory = 512
            }
        }
    }
}