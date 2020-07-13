---
title: "Nomad Connect Integration"
author: "Erik Veld"
slug: "nomad-connect-integration"
---
## Nomad Connect integration

Explain the setup we have...

Explain the job that we are running (web -> database)

```shell
nomad run nomad_jobs/api.hcl
```

Explain what is created, how the sidecar task is automatically injected.
Explain the upstream.

```shell
nomad run nomad_jobs/database.hcl
```

Explain how it now all works.
Show flow diagram via sidecars.

```shell
curl http://localhost:8080
```
