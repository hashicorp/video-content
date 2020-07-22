job "api" {
    datacenters = ["dc1"]
    type = "service"

    group "api" {
        count = 3

        network {
            mode = "cni/bridge"

            port "http" {
                to = 9090
            }
        }

        service {
            name = "fml"
            port = 9090

            connect {
                sidecar_service {}
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