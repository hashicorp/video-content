job "postgres" {
  datacenters = ["dc1"]
  type = "service"
  
  group "postgres" {
    count = 1

    network {
      mode = "bridge"

      port "database" {
        static = 5432
        to = 5432
      }
    }

    task "postgres" {
      driver = "docker"

      env {
        POSTGRES_USER = "root"
        POSTGRES_PASSWORD = "insecure"
        POSTGRES_DB = "database"
      }

      template {
          data = <<EOF
CREATE TABLE natural_gas_prices
(
  date date,
  price float
)
EOF
        destination = "local/natural_gas_prices.sql"
      }

      config {
        image = "postgres"
        volumes = ["local/natural_gas_prices.sql:/docker-entrypoint-initdb.d/natural_gas_prices.sql"]
      }

      resources {
        cpu    = 100
        memory = 256
      }
    }
  }
}