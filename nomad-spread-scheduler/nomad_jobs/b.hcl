job "backend" {
    datacenters = ["dc1"]
    type = "service"

    group "backend" {
        count = 1

        network {
            mode = "bridge"
        }

        task "backend" {
            driver = "docker"

            config {
                image = "nicholasjackson/fake-service:v0.14.1"
            }

            env {
                NAME = "backend (${NOMAD_ALLOW_ID})"
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