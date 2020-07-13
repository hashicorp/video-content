job "web" {
  datacenters = ["dc1"]
  type = "service"
  
  group "web" {
    count = 1

    network {
      mode = "bridge"

      # We are adding this so we can reach 
      # the web service on our local machine.
      port "http" {
        static = 8080
        to = 8080
      }
    }

    task "web" {
      driver = "docker"

      template {
        data = <<EOF
static_resources:
  listeners:
  - address:
      socket_address:
        address: 0.0.0.0
        port_value: 8080
    filter_chains:
    - filters:
      - name: envoy.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager
          codec_type: http1
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: backend
              domains:
              - "*"
              routes:
              - match:
                  prefix: "/"
                route:
                  cluster: api
          http_filters:
          - name: envoy.router
            typed_config: {}
  clusters:
  - name: api
    connect_timeout: 0.25s
    max_requests_per_connection: 1
    type: strict_dns
    lb_policy: round_robin
    load_assignment:
      cluster_name: api
      endpoints:
      - lb_endpoints:
      {{ range service "api" }}
        - endpoint:
            address:
              socket_address:
                address: {{ .Address }}
                port_value: {{ .Port }}
                ipv4_compat: true
      {{ end }}
admin:
  access_log_path: "/dev/null"
  address:
    socket_address:
      address: 0.0.0.0
      port_value: 19000
EOF
        destination   = "local/envoy.yaml"
      }

      config {
        image = "envoyproxy/envoy-alpine:v1.13.1"

        volumes = [
          "local/envoy.yaml:/etc/envoy/envoy.yaml",
        ] 
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }
  }
}