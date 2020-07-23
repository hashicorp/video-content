nomad_cluster "dc1" {
  version = "v0.12.0"

  client_config = <<EOF
client {
	enabled = true

	server_join {
		retry_join = ["server.dc1.nomad_cluster.shipyard.run"]
	}

  cni_path = "/opt/cni/bin"
  cni_config_dir = "/opt/cni/config"
}
EOF

  network {
    name = "network.dc1"
  }

  image {
    name = "nicholasjackson/fake-service:v0.14.1"
  }

  volume {
    source = "./nomad_config/calico.json"
    destination = "/opt/cni/config/calico.json"
  }
}