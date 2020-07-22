nomad_cluster "dc1" {
  version = "v0.12.0"

  // client_nodes = 3

//   server_config = <<EOF
// server {
//   enabled = true
//   bootstrap_expect = 1

//   // default_scheduler_config {
//   //   scheduler_algorithm = "spread"

//   //   preemption_config {
//   //     batch_scheduler_enabled   = true
//   //     system_scheduler_enabled  = true
//   //     service_scheduler_enabled = true
//   //   }
//   // }
// }
// EOF

//   client_config = <<EOF
// client {
// 	enabled = true

// 	server_join {
// 		retry_join = ["server.dc1.nomad_cluster.shipyard.run"]
// 	}
// }

// plugin "raw_exec" {
//   config {
// 	  enabled = true
//   }
// }
// EOF

  network {
    name = "network.dc1"
  }

  image {
    name = "nicholasjackson/fake-service:v0.14.1"
  }
}