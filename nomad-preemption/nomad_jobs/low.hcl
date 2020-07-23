job "low" {
    datacenters = ["dc1"]
    type = "service"

    priority = 50

    group "low" {
        count = 1

        network {
            mode = "bridge"

            port "http" {
                to = 9090
            }
        }
        
        task "low" {
            driver = "docker"

            config {
                image = "nicholasjackson/fake-service:v0.14.1"
            }

            env {
                NAME = "low"
                MESSAGE = "ok"
                LISTEN_ADDR = "0.0.0.0:9090"
            }

            resources {
                cpu    = 50
                memory = 1024
            }
        }
    }
}