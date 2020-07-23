job "api" {
    datacenters = ["dc1"]
    type = "service"

    group "api" {
        count = 1

        network {
            mode = "cni/mynet"

            port "http" {
                to = 9090
            }
        }

        task "api" {
            driver = "docker"

            config {
                image = "nicholasjackson/fake-service:v0.14.1"
            }

            env {
                NAME = "api (${NOMAD_ALLOC_ID})"
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