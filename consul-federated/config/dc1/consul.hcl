data_dir = "/tmp"
log_level = "DEBUG"

datacenter = "dc1"
primary_datacenter = "dc1"

server = true

bootstrap_expect = 1
ui = true

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
advertise_addr = "{{GetInterfaceIP \"eth1\"}}"

key_file  = "/etc/consul/tls/dc1-server-consul.container.shipyard.run-0-key.pem"
cert_file = "/etc/consul/tls/dc1-server-consul.container.shipyard.run-0.pem"
ca_file   = "/etc/consul/tls/consul.container.shipyard.run-agent-ca.pem"

ports {
  grpc = 8502
  https = 8501 
}

connect {
  enabled = true
  enable_mesh_gateway_wan_federation = true
}

acl {
  enabled = true
  default_policy = "deny"
  down_policy = "extend-cache"
  enable_token_persistence = true
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