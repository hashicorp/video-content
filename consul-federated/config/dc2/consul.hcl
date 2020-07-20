data_dir = "/tmp"
log_level = "DEBUG"

datacenter = "dc2"
primary_datacenter = "dc1"

server = true

bootstrap_expect = 1
ui = true

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
advertise_addr = "{{GetInterfaceIP \"eth1\"}}"

#retry_join = ["consul-1.container.shipyard.run", "consul-2.container.shipyard.run", "consul-3.container.shipyard.run"]

key_file  = "/etc/consul/tls/dc2-server-consul.container.shipyard.run-0-key.pem"
cert_file = "/etc/consul/tls/dc2-server-consul.container.shipyard.run-0.pem"
ca_file   = "/etc/consul/tls/consul.container.shipyard.run-agent-ca.pem"

ports {
  grpc = 8502
  https = 8501 
}

primary_gateways = [ "gateway.dc1.consul.container.shipyard.run:443"]

connect {
  enabled = true
  enable_mesh_gateway_wan_federation = true
}

acl {
  enabled = true
  default_policy = "deny"
  down_policy = "extend-cache"
  enable_token_persistence = true
  enable_token_replication = true
}

config_entries {
  # We are using gateways and L7 config set the 
  # default protocol to HTTP
  bootstrap 
    {
      kind = "proxy-defaults"
      name = "global"

      config {
        protocol = "http"
      }

      mesh_gateway = {
        mode = "local"
      }
    }
}