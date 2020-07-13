job "import" {
  datacenters = ["dc1"]
  type = "batch"
  
  group "import" {
    count = 1

    // network {
    //   mode = "bridge"
    // }

    task "import" {
      driver = "docker"

      artifact {
        source = "https://datahub.io/core/natural-gas/r/daily.csv"
      }

      env {
        PGPASSWORD="insecure"
      }

      config {
        image = "postgres"
        command = "psql"
        args =["-h", "${attr.unique.network.ip-address}", "-p", "5432", "-d", "database", "-U", "root", "-w", "-c", "\\copy natural_gas_prices FROM '/tmp/import.csv' DELIMITER ',' CSV HEADER;"]
        volumes = ["local/daily.csv:/tmp/import.csv"]
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }
  }
}