data_dir = "/etc/nomad.d/data"
datacenter = "dc1"
region = "eu"

addresses {
  http = "0.0.0.0"
  rpc = "0.0.0.0"
  serf = "0.0.0.0"
}

advertise {
  serf = "192.168.10.100"
}

server {
  enabled = true
  bootstrap_expect = 1
}

client {
    enabled = true
}