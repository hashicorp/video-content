job "api" {
  datacenters = ["dc1"]
  type = "service"
  
  group "api" {
    count = 1

    network {
      mode = "bridge"

      port "http" {
        to = 9090
      }
    }

    scaling {
      min = 1
      max = 5
      enabled = true

      policy {
        evaluation_interval = "5s"
        cooldown = "1m"

        check "average_cpu" {
          source = "nomad-apm"
          query  = "max_cpu"

          strategy "target-value" {
            target = 10
          }
        }
      }
    }
     
    service {
      name = "api"
      port = "http"
    }

    task "api" {
      driver = "docker"

      env {
        LISTEN_ADDR = "0.0.0.0:9090"
        MESSAGE = "Hello from ${NOMAD_ALLOC_ID}"
        NAME = "api"
        LOAD_CPU_CORES = "1"
        LOAD_CPU_PERCENTAGE = "1"
        TIMING_50_PERCENTILE = "10ms"
        SERVER_TYPE = "http"
      }

      config {
        image = "nicholasjackson/fake-service:v0.9.0"
      }

      resources {
        cpu = 1000
        memory = 64
      }
    }
  }
}