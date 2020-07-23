nomad_cluster "dc1" {
  version = "v0.12.0"

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