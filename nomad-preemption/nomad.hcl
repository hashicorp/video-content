nomad_cluster "dc1" {
  version = "v0.12.0"

  server_config = <<EOF
server {
  enabled = true
  bootstrap_expect = 1

  default_scheduler_config {
    preemption_config {
      batch_scheduler_enabled   = true
      system_scheduler_enabled  = true
      service_scheduler_enabled = true
    }
  }
}
EOF

  client_config = <<EOF
client {
	enabled = true

	server_join {
		retry_join = ["server.dc1.nomad_cluster.shipyard.run"]
	}

  memory_total_mb = 2000
  reserved {
    memory = 20
  }
}
EOF

  network {
    name = "network.dc1"
  }

  image {
    name = "nicholasjackson/fake-service:v0.14.1"
  }
}