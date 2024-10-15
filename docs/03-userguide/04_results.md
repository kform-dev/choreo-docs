# Results

In Choreo, results management is intricately designed to cater to both development and production environments, leveraging logs and API interactions to monitor and understand the status and output of operations.

## Production

In a production setting, users/machines can consult logs or interact directly with the API server to check the status of resources. This provides a real-time insight into the system’s operational status, helping identify any issues or confirm the health of the processes.

## Development

The development environment is enhanced with additional tools to aid in testing and troubleshooting:

- Observer Insights: The observer component plays a critical role in development mode by informing users about the success or failure of each run. This immediate feedback is crucial for iterative development and troubleshooting.
- Snapshot Storage: Upon a successful run, a snapshot of the data produced during that operation is stored. This allows developers to capture and review the state of the system at the time of execution, which is invaluable for debugging and historical analysis.

### Managing Results with Choreo Commands

#### Running and Observing Operations

To initiate a run and observe the results in development mode, use the following command:

```bash
choreoctl run once
```

This command executes the operational logic once and provides an output summarizing the execution:

```bash
execution success, time(sec) 0.019575833
Reconciler                                       Start Stop Requeue Error
nf.nephio.org.nfdeployments.upf.free5gc.io.claim     2    2       0     0
nf.nephio.org.nfdeployments.upf.free5gc.io.ready     1    1       0     0
...
```

####  Analyzing Changes with Snapshots

Developers can compare current results with previous snapshots to understand the impact of changes:

```bash
choreoctl run diff
```

This command outputs a detailed list of changes between the current and previous runs, helping identify new or altered resources:

```bash
+ infra.kuid.dev/v1alpha1, Kind=Cluster nephio.region1.us-east.cluster1
+ infra.kuid.dev/v1alpha1, Kind=Cluster nephio.region2.us-west.cluster1
...
```

Snapshot Options

Choreo also provides options to enhance the detail level in snapshot comparisons:

- -i option: Includes internal Choreo API states in the diff.
- -a option: Displays detailed attributes of each element.
- -m option: Shows managed fields details, providing deeper insights into what has changed and why.

example with -a option

```bash
choreoctl run diff
```

output

```bash
+ req.nephio.org/v1alpha1, Kind=DataNetwork nephio.internet.ipv4
  map[string]any(
-       nil,
+       {
+               "apiVersion": string("req.nephio.org/v1alpha1"),
+               "kind":       string("DataNetwork"),
+               "metadata": map[string]any{
+                       "annotations":       map[string]any{"api.choreo.kform.dev/origin": string(`{"kind":"File"}`)},
+                       "creationTimestamp": string("2024-10-11T07:03:25Z"),
+                       "finalizers":        []any{string("req.nephio.org.dnns.claim"), string("req.nephio.org.dnns.ready")},
+                       "name":              string("nephio.internet.ipv4"),
+                       "namespace":         string("default"),
+                       "resourceVersion":   string("2"),
+                       "uid":               string("387b5e9d-acb9-4c08-9b95-8cc8239a87e6"),
+               },
+               "spec": map[string]any{"network": string("vpc-internet"), "pools": []any{map[string]any{...}}},
+               "status": map[string]any{
+                       "conditions": []any{map[string]any{...}, map[string]any{...}},
+                       "pools":      []any{map[string]any{...}},
+               },
+       },
  )
```

#### Viewing Dependencies

Understanding dependencies between resources is critical for managing complex systems. Choreo facilitates this with visualization commands that delineate how resources are interconnected:

```bash
choreoctl deps
```

This functionality not only aids in troubleshooting but also helps in planning and verifying system architecture integrity.



```bash
...
NFDeployment.nf.nephio.org/v1alpha1 nephio.region1.us-east1.cluster1.upf1
+-Attachment.req.kuid.dev/v1alpha1 nephio.region1.us-east1.cluster1.upf1.n3
+-Attachment.req.kuid.dev/v1alpha1 nephio.region1.us-east1.cluster1.upf1.n4
+-Attachment.req.kuid.dev/v1alpha1 nephio.region1.us-east1.cluster1.upf1.n6
...
```

you can see that NFDeployment.nf.nephio.org/v1alpha1 nephio.region1.us-east1.cluster1.upf1 has 3 children:

- Attachment.req.kuid.dev/v1alpha1 nephio.region1.us-east1.cluster1.upf1.n3
- Attachment.req.kuid.dev/v1alpha1 nephio.region1.us-east1.cluster1.upf1.n4
 - Attachment.req.kuid.dev/v1alpha1 nephio.region1.us-east1.cluster1.upf1.n6