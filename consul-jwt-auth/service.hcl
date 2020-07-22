container "api" {
  image {
    name = "nicholasjackson/fake-service:vm-v0.15.0"
  }

  volume {
    source      = "./api"
    destination = "/config"
  }
  
  volume {
    source      = "${data("tls")}"
    destination = "/etc/consul/tls"
  }

  network { 
    name = "network.dc1"
  }
  
  env_var = {
    PRESTART_FILE = "/config/consul_login.sh"
    CONSUL_HTTP_TOKEN_FILE = "/consul.token"
    CONSUL_SERVER = "1.server.dc1.consul.container.shipyard.run"
    CONSUL_CACERT = "/etc/consul/tls/consul.container.shipyard.run-agent-ca.pem"
    SERVICE_ID = "api-1"
    LISTEN_ADDR = "0.0.0.0:9090"
    NAME = "API"
    MESSAGE = "Hello from API"
  }
}