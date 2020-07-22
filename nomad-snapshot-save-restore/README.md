---
title: "Nomad Spread Scheduler"
author: "Erik Veld"
slug: "nomad-spread-scheduler"
---
```shell
shipyard run
```

```shell
nomad run nomad_jobs/api.hcl
```

```shell
nomad operator snapshot save backup.snap
```

```shell
shipyard taint nomad_cluster.dc1
```

```shell
shipyard run
```

```shell
nomad operator snapshot restore backup.snap
```
