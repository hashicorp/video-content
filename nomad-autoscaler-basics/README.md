---
title: "Nomad Autoscaler Basics"
author: "Erik Veld"
slug: "nomad-autoscaler-basics"
---
## Nomad Autoscaler Basics

Explain the setup we have...

Define where the autoscaler plugins are located by configuring the `plugin_dir` field.

```hcl
plugin_dir = "./plugins"
scan_interval = "10s"
```

In order for the Nomad Autoscaler to take action when noticing

```hcl
nomad {
  address = "http://{{ env "attr.unique.network.ip-address" }}:4646"
}
```

Code snippet config apm

```hcl
apm "nomad" {
  driver = "nomad-apm"
}
```

Code snippet strategy

```hcl
strategy "target-value" {
  driver = "target-value"
}
```
