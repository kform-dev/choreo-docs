# Results

In Choreo, results management is intricately designed to cater to both development and production environments, leveraging logs and API interactions to monitor and understand the status and output of operations.

## Developer mode

The development environment is enhanced with additional tools to aid in testing and troubleshooting:

- Observer Insights: The observer component plays a critical role in development mode by informing users about the success or failure of each run. This immediate feedback is crucial for iterative development and troubleshooting.
- Snapshot Storage: Upon a successful run, a snapshot of the data produced during that operation is stored. This allows developers to capture and review the state of the system at the time of execution, which is invaluable for debugging and historical analysis.

### Managing Results with Choreo Commands

#### Running and Observing Operations

To initiate a run and observe the results in development mode, use the following command:

```shell
choreoctl run once
```

This command executes the operational logic once and provides an output summarizing the execution:

```shell
loading ...
opened repo https://github.com/kuidio/kuid.git ref cb752b9df3fe1ca9285a40e10d44dc87cd021162 ....
opened repo https://github.com/kubenet-dev/apis.git ref 71e5d139d272026db682be8a815d33a9f10d7b1f ....
opened repo https://github.com/sdcio/config-server.git ref aaf183a28ba8a3cff222321a767fc0022923af19 ....
loading done
running reconcilers ...
running root reconciler config
Run root summary
execution success, time(msec) 11.471ms
Reconciler                                                 Start Stop Requeue Error
device.network.kubenet.dev.interfaces.srlinux.nokia.com    4     4    0       0    
device.network.kubenet.dev.subinterfaces.srlinux.nokia.com 2     2    0       0    
nodes.infra.kuid.dev.id                                    2     2    0       0    
nodes.infra.kuid.dev.itfce                                 2     2    0       0    
running config validator ...
completed
```

####  Analyzing Changes with Snapshots

Developers can compare current results with previous snapshots to understand the impact of changes:

```shell
choreoctl run diff
```

This command outputs a detailed list of changes between the current and previous runs, helping identify new or altered resources:

```shell
= config.sdcio.dev/v1alpha1, Kind=Config interface.kubenet.region1.us-east.node1.0.0.irb
= config.sdcio.dev/v1alpha1, Kind=Config interface.kubenet.region1.us-east.node1.0.0.system
~ config.sdcio.dev/v1alpha1, Kind=Config kubenet.region1.us-east.node1
= config.sdcio.dev/v1alpha1, Kind=Config subinterface.kubenet.region1.us-east.node1.0.0.0.system
= config.sdcio.dev/v1alpha1, Kind=RunningConfig kubenet.region1.us-east.node1
~ config.sdcio.dev/v1alpha1, Kind=RunningConfig kubenet.region1.us-east.node1.tree
= device.network.kubenet.dev/v1alpha1, Kind=Interface kubenet.region1.us-east.node1.0.0.irb
= device.network.kubenet.dev/v1alpha1, Kind=Interface kubenet.region1.us-east.node1.0.0.system
= device.network.kubenet.dev/v1alpha1, Kind=SubInterface kubenet.region1.us-east.node1.0.0.0.system
= infra.kuid.dev/v1alpha1, Kind=Node kubenet.region1.us-east.node1
= ipam.be.kuid.dev/v1alpha1, Kind=IPClaim kubenet.default.10.0.0.0-24
= ipam.be.kuid.dev/v1alpha1, Kind=IPClaim kubenet.default.1000---32
= ipam.be.kuid.dev/v1alpha1, Kind=IPClaim kubenet.region1.us-east.node1.ipv4
= ipam.be.kuid.dev/v1alpha1, Kind=IPEntry default.kubenet.default.10.0.0.0-24
= ipam.be.kuid.dev/v1alpha1, Kind=IPEntry default.kubenet.default.10.0.0.0-32
= ipam.be.kuid.dev/v1alpha1, Kind=IPEntry default.kubenet.default.1000---32
= ipam.be.kuid.dev/v1alpha1, Kind=IPIndex kubenet.default
...
```

Snapshot Options

Choreo also provides options to enhance the detail level in snapshot comparisons:

- -i option: Includes internal Choreo API states in the diff.
- -a option: Displays detailed attributes of each element.
- -m option: Shows managed fields details, providing deeper insights into what has changed and why.

example with -a option

```shell
choreoctl run diff -a
```

output

```shell
+= config.sdcio.dev/v1alpha1, Kind=Config interface.kubenet.region1.us-east.node1.0.0.irb
= config.sdcio.dev/v1alpha1, Kind=Config interface.kubenet.region1.us-east.node1.0.0.system
~ config.sdcio.dev/v1alpha1, Kind=Config kubenet.region1.us-east.node1
  bytes.Join({
        "apiVersion: config.sdcio.dev/v1alpha1\nkind: Config\nmetadata:\n  c",
        "reationTimestamp: \"2024-11-12T11:01:37Z\"\n  generation: ",
-       "6",
+       "7",
        "\n  labels:\n    config.sdcio.dev/targetName: kubenet.region1.us-e",
        "ast.node1\n    config.sdcio.dev/targetNamespace: default\n  name: ",
        ... // 124 identical bytes
        ": true\n    kind: Node\n    name: kubenet.region1.us-east.node1\n  ",
        "  uid: 1ecb56f1-4331-4a2e-98f7-92a2aef04cfd\n  resourceVersion: \"",
-       "6",
+       "7",
        "\"\n  uid: b9144c27-09cb-4790-9d8c-31896ce8e09a\nspec:\n  config:\n  ",
        "- path: /\n    value:\n      interface:\n      - admin-state: enabl",
        "e\n        description: k8s-",
-       "irb\n        name: irb0\n      - admin-state: enable\n        descr",
-       "iption: k8s-system\n        name: system0\n        subinterface:\n ",
-       "       - admin-state: enable\n          description: k8s-system.0",
-       "\n          index: 0\n          ipv4:\n            address:\n       ",
-       "     - ip-prefix: 10.0.0.0/32\n           ",
+       "system\n        name: system0\n        subinterface:\n        - adm",
+       "in-state: enable\n          description: k8s-system.0\n          i",
+       "ndex: 0\n          ipv4:\n            address:\n            - ip-pr",
+       "efix: 10.0.0.0/32\n            admin-state: enable\n            un",
+       "numbered:\n              admin-state: disable\n      -",
        " admin-state: enable\n        ",
-       "    unnumbered:\n              admin-state: disable",
+       "description: k8s-irb\n        name: irb0",
        "\n      network-instance:\n      - admin-state: enable\n        des",
        "cription: Management network instance\n        name: mgmt\n       ",
        ... // 10384 identical bytes
  }, "")

= config.sdcio.dev/v1alpha1, Kind=Config subinterface.kubenet.region1.us-east.node1.0.0.0.system
= config.sdcio.dev/v1alpha1, Kind=RunningConfig kubenet.region1.us-east.node1
~ config.sdcio.dev/v1alpha1, Kind=RunningConfig kubenet.region1.us-east.node1.tree
  bytes.Join({
        ... // 249 identical bytes
        ": true\n    kind: Node\n    name: kubenet.region1.us-east.node1\n  ",
        "  uid: 1ecb56f1-4331-4a2e-98f7-92a2aef04cfd\n  resourceVersion: \"",
-       "2",
+       "3",
        "\"\n  uid: 29cbcf9d-127e-4750-8cba-069560cf82d0\nspec: {}\nstatus:\n ",
        " value:\n    network-instance:\n    - admin-state: enable\n      de",
        ... // 4581 identical bytes
        "      server-list:\n        - 10.210.21.227\n        - 10.210.21.2",
        "28\n      grpc-server:\n      - admin-state: enable\n        name: ",
+       "insecure-",
        "mgmt\n        network-instance: mgmt\n        ",
-       "rate-limit: 65000\n        services:\n        - gnmi\n        - gno",
-       "i\n        - gribi\n        - p4rt\n        tls-profile: clab-profi",
-       "le\n        trace-options:\n        - request\n        - response\n ",
-       "       - common\n        unix-socket:\n          admin-state: enab",
-       "le\n      - admin-state: enable\n        name: insecure-mgmt\n     ",
-       "   network-instance: mgmt\n        port: 57401\n        rate-limit",
-       ": 65000\n        services:\n        - gnmi\n        - gnoi\n        ",
-       "- gribi\n        - p4rt",
+       "port: 57401\n        rate-limit: 65000\n        services:\n        ",
+       "- gnmi\n        - gnoi\n        - gribi\n        - p4rt\n        tra",
+       "ce-options:\n        - request\n        - response\n        - commo",
+       "n\n        unix-socket:\n          admin-state: enable\n      - adm",
+       "in-state: enable\n        name: mgmt\n        network-instance: mg",
+       "mt\n        rate-limit: 65000\n        services:\n        - gnmi\n  ",
+       "      - gnoi\n        - gribi\n        - p4rt\n        tls-profile:",
+       " clab-profile",
        "\n        trace-options:\n        - request\n        - response\n   ",
        "     - common\n        unix-socket:\n          admin-state: enable",
        ... // 4782 identical bytes
  }, "")

= device.network.kubenet.dev/v1alpha1, Kind=Interface kubenet.region1.us-east.node1.0.0.irb
= device.network.kubenet.dev/v1alpha1, Kind=Interface kubenet.region1.us-east.node1.0.0.system
= device.network.kubenet.dev/v1alpha1, Kind=SubInterface kubenet.region1.us-east.node1.0.0.0.system
= infra.kuid.dev/v1alpha1, Kind=Node kubenet.region1.us-east.node1
= ipam.be.kuid.dev/v1alpha1, Kind=IPClaim kubenet.default.10.0.0.0-24
= ipam.be.kuid.dev/v1alpha1, Kind=IPClaim kubenet.default.1000---32
= ipam.be.kuid.dev/v1alpha1, Kind=IPClaim kubenet.region1.us-east.node1.ipv4
= ipam.be.kuid.dev/v1alpha1, Kind=IPEntry default.kubenet.default.10.0.0.0-24
= ipam.be.kuid.dev/v1alpha1, Kind=IPEntry default.kubenet.default.10.0.0.0-32
= ipam.be.kuid.dev/v1alpha1, Kind=IPEntry default.kubenet.default.1000---32
= ipam.be.kuid.dev/v1alpha1, Kind=IPIndex kubenet.default
```

#### Viewing Dependencies

Understanding dependencies between resources is critical for managing complex systems. Choreo facilitates this with visualization commands that delineate how resources are interconnected:

```shell
choreoctl run deps
```

This functionality not only aids in troubleshooting but also helps in planning and verifying automation integrity.


```shell
...
IPIndex.ipam.be.kuid.dev/v1alpha1 kubenet.default
+-IPClaim.ipam.be.kuid.dev/v1alpha1 kubenet.default.10.0.0.0-24
  +-IPEntry.ipam.be.kuid.dev/v1alpha1 default.kubenet.default.10.0.0.0-24
+-IPClaim.ipam.be.kuid.dev/v1alpha1 kubenet.default.1000---32
  +-IPEntry.ipam.be.kuid.dev/v1alpha1 default.kubenet.default.1000---32
Node.infra.kuid.dev/v1alpha1 kubenet.region1.us-east.node1
+-Config.config.sdcio.dev/v1alpha1 kubenet.region1.us-east.node1
+-Interface.device.network.kubenet.dev/v1alpha1 kubenet.region1.us-east.node1.0.0.irb
  +-Config.config.sdcio.dev/v1alpha1 interface.kubenet.region1.us-east.node1.0.0.irb
+-Interface.device.network.kubenet.dev/v1alpha1 kubenet.region1.us-east.node1.0.0.system
  +-Config.config.sdcio.dev/v1alpha1 interface.kubenet.region1.us-east.node1.0.0.system
+-IPClaim.ipam.be.kuid.dev/v1alpha1 kubenet.region1.us-east.node1.ipv4
  +-IPEntry.ipam.be.kuid.dev/v1alpha1 default.kubenet.default.10.0.0.0-32
+-RunningConfig.config.sdcio.dev/v1alpha1 kubenet.region1.us-east.node1
+-RunningConfig.config.sdcio.dev/v1alpha1 kubenet.region1.us-east.node1.tree
+-SubInterface.device.network.kubenet.dev/v1alpha1 kubenet.region1.us-east.node1.0.0.0.system
  +-Config.config.sdcio.dev/v1alpha1 subinterface.kubenet.region1.us-east.node1.0.0.0.system
...
```

#### Viewing Result

Understanding the details of the result execution is possible with the following command

- -o option: allows to customize the output format using the following options
  - reconciler: provides a summary per reconciler (default output format)
  - resource: provides a summary per resource
  - raw: provides a view on the sequence of the reconciler execution


```shell
choreoctl run result -o raw
```

example output

```shell
Run root summary
execution success, time(msec) 11.471ms
EventTime                      Reconciler                                                 Resource                                                                                   Operation Message
2024-11-13 00:59:50.240876 UTC nodes.infra.kuid.dev.id                                    infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  START            
2024-11-13 00:59:50.240899 UTC nodes.infra.kuid.dev.itfce                                 infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  START            
2024-11-13 00:59:50.240980 UTC device.network.kubenet.dev.subinterfaces.srlinux.nokia.com device.network.kubenet.dev.SubInterface.default.kubenet.region1.us-east.node1.0.0.0.system START            
2024-11-13 00:59:50.241316 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.system      START            
2024-11-13 00:59:50.241344 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.irb         START            
2024-11-13 00:59:50.244228 UTC device.network.kubenet.dev.subinterfaces.srlinux.nokia.com device.network.kubenet.dev.SubInterface.default.kubenet.region1.us-east.node1.0.0.0.system STOP             
2024-11-13 00:59:50.244235 UTC device.network.kubenet.dev.subinterfaces.srlinux.nokia.com device.network.kubenet.dev.SubInterface.default.kubenet.region1.us-east.node1.0.0.0.system START            
2024-11-13 00:59:50.244307 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.irb         STOP             
2024-11-13 00:59:50.244315 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.irb         START            
2024-11-13 00:59:50.244348 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.system      STOP             
2024-11-13 00:59:50.244353 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.system      START            
2024-11-13 00:59:50.245140 UTC nodes.infra.kuid.dev.id                                    infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  STOP             
2024-11-13 00:59:50.245145 UTC nodes.infra.kuid.dev.id                                    infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  START            
2024-11-13 00:59:50.246552 UTC nodes.infra.kuid.dev.itfce                                 infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  STOP             
2024-11-13 00:59:50.246557 UTC nodes.infra.kuid.dev.itfce                                 infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  START            
2024-11-13 00:59:50.247734 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.irb         STOP             
2024-11-13 00:59:50.247792 UTC device.network.kubenet.dev.interfaces.srlinux.nokia.com    device.network.kubenet.dev.Interface.default.kubenet.region1.us-east.node1.0.0.system      STOP             
2024-11-13 00:59:50.248088 UTC device.network.kubenet.dev.subinterfaces.srlinux.nokia.com device.network.kubenet.dev.SubInterface.default.kubenet.region1.us-east.node1.0.0.0.system STOP             
2024-11-13 00:59:50.250149 UTC nodes.infra.kuid.dev.id                                    infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  STOP             
2024-11-13 00:59:50.252347 UTC nodes.infra.kuid.dev.itfce                                 infra.kuid.dev.Node.default.kubenet.region1.us-east.node1                                  STOP   
```

## Production mode

In a production setting, users/machines can consult logs or interact directly with the API server to check the status of resources. This provides a real-time insight into the system’s operational status, helping identify any issues or confirm the health of the processes.