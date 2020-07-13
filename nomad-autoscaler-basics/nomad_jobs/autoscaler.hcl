job "autoscaler" {
    datacenters = ["dc1"]
    type = "service"

    group "autoscaler" {
        count = 1

        network {
            mode = "bridge"
        }

        task "agent" {
            driver = "docker"
            
            template {
                destination = "local/config.hcl"
                data = <<EOH
plugin_dir = "./plugins"

nomad {
  address = "http://{{ env "attr.unique.network.ip-address" }}:4646"
}

apm "nomad-apm" {
  driver = "nomad-apm"
}

strategy "target-value" {
  driver = "target-value"
}
                EOH
            }

            config {
                image = "hashicorp/nomad-autoscaler:0.1.0"
                command = "/bin/nomad-autoscaler"
                args = [
                    "agent",
                    "-config=/config.hcl"
                ]
                volumes = ["local/config.hcl:/config.hcl"]
            }

            resources {
                cpu    = 50
                memory = 64
            }
        }
    }
}