Feature: Federated Consul with JWT
  In order to test my blueprint
  I should apply a blueprint which defines a federated consul
  cluster with TLS and ACLs enabled

Scenario: Federated Consul cluster
 Given the following shipyard variables are set
    | key            | value                 |
    | consul_version | <consul>              |
    | envoy_version  | <envoy>               |
  And I have a running blueprint
  Then the following resources should be running
    | name                | type      |
    | dc1                 | network   |
    | dc2                 | network   |
    | wan                 | network   |
    | 1.server.dc1.consul | container |
    | 1.server.dc2.consul | container |
  And the info "{.HostConfig.PortBindings['8501/'][0].HostPort}" for the running "container" called "1.server.dc1.consul" should equal "18501"
  And when I run the script
  ```
  #!/bin/bash
  # Wait for consul to elect a leader
  sleep 10

  curl -k https://1.server.dc1.consul.container.shipyard.run:18501/v1/status/leader
  ```
  Then I expect the exit code to be 0
  And I expect the response to contain "`.*:8300`"
  Then when I run the command "curl -k https://1.server.dc1.consul.container.shipyard.run:18501/v1/status/leader"
  And I expect the exit code to be 0
  Examples:
    | consul            | envoy    |
    | 1.8.0             | 1.12.4   |