nomad_cluster "dc1" {
  version = "v0.12.0"

  client_config = <<EOF
client {
	enabled = true

	server_join {
		retry_join = ["server.dc1.nomad_cluster.shipyard.run"]
	}

  host_network "wan" {
    cidr = "192.168.0.0/16"
  }

  host_network "private" {
    cidr = "10.5.0.0/16"
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