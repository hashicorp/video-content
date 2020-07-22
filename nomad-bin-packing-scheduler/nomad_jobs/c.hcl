job "cache" {
    datacenters = ["dc1"]
    type = "service"

    group "cache" {
        count = 3

        network {
            mode = "bridge"
        }

        task "cache" {
            driver = "docker"

            config {
                image = "nicholasjackson/fake-service:v0.14.1"
            }

            env {
                NAME = "cache (${NOMAD_ALLOW_ID})"
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