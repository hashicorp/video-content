job "all" {
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

    group "cache" {
        count = 1

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