job "high" {
    datacenters = ["dc1"]
    type = "service"

    priority = 100

    group "high" {
        count = 1

        network {
            mode = "bridge"

            port "http" {
                to = 9090
            }
        }
        
        task "high" {
            driver = "docker"

            config {
                image = "nicholasjackson/fake-service:v0.14.1"
            }

            env {
                NAME = "high"
                MESSAGE = "ok"
                LISTEN_ADDR = "0.0.0.0:9090"
            }

            resources {
                cpu    = 50
                memory = 64
            }
        }
    }
}