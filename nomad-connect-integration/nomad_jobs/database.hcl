job "database" {
  datacenters = ["dc1"]
  type = "service"
  
  group "database" {
    count = 1

    network {
      mode = "bridge"
    }
     
    service {
      name = "database"
      port = "5432"

      connect {
        sidecar_service {}
      }
    }

    task "database" {
      driver = "docker"

      env {
        LISTEN_ADDR = "0.0.0.0:5432"
        MESSAGE = "1 Row returned"
        NAME = "database"
        SERVER_TYPE = "http"
      }

      config {
        image = "nicholasjackson/fake-service:v0.9.0"
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }
  }
}