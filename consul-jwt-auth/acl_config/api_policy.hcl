node "api" {
  policy = "write"
}

agent "api" {
  policy = "write"
}

key_prefix "_rexec" {
  policy = "write"
}

service "api" {
	policy = "write"
}

service "api-sidecar-proxy" {
	policy = "write"
}

service_prefix "" {
	policy = "read"
}

node_prefix "" {
	policy = "read"
}