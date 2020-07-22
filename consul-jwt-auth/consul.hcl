module "consul" {
  source = "../consul-federated"
}

## Configure ACLs Auth for JWT
exec_remote "bootstrap_acl_jwt_auth" {
  depends_on = ["module.consul"]

  image   {
    name = "nicholasjackson/consul-envoy:v1.8.0-v1.12.4"
  }

  working_directory = "/scripts"
  cmd = "/scripts/setup_auth.sh"
  
  network {
    name = "network.dc1"
  }

  env_var =  {
    CONSUL_CACERT = "/etc/consul/tls/consul.container.shipyard.run-agent-ca.pem"
    CONSUL_HTTP_ADDR = "https://1.server.dc1.consul.container.shipyard.run:8501"
    CONSUL_HTTP_TOKEN_FILE = "/tokens/token_dc1.txt"
  }

  volume {
    source      = "./acl_config"
    destination = "/scripts"
  }
  
  volume {
    source      = "${data("tls")}"
    destination = "/etc/consul/tls"
  }
  
  volume {
    source      = "${data("tokens")}"
    destination = "/tokens"
  }
}