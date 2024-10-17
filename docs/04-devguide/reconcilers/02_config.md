# Reconciler Config

In Choreo, a reconciler configuration is defined within a reconciler resource, where developers specify hooks and their respective parameters. This configuration determines how the reconciler interacts with the system’s resources.

```yaml
apiVersion: choreo.kform.dev/v1alpha1
kind: Reconciler
```

### For Resource hook

The for resource hook is mandatory and identifies the primary resource that the reconciler manages. It is sometimes referred to as the primary resource.

```yaml
for: 
  group: nf.nephio.org
  version: v1alpha1
  kind: NFDeployment
  selector:
    match:
      spec.provider: upf.free5gc.io
```

Parameters:

- GVK (Group, Version, Kind): Identifies the for resource.
- Filters: Specify criteria to select specific resources for reconciliation. These filters use the CEL (Common Expression Language) functionality, allowing for complex logic across all resource fields, including lists and maps. Filters operate under a default-deny policy and require explicit whitelisting.


## Watch resource hook

The watch resource hook is optional and used when a reconciler depends on external data or other resources for its logic. Changes in any watched resources specified in the reconciler configuration will trigger the reconciliation process for the associated primary resource.

```yaml
  watches:
  - group: req.nephio.org
    version: v1alpha1
    kind: Capacity
    selector:
      match:
        metadata.name: upf
```

Parameters:

- GVK (Group, Version, Kind): Identifies the watch resource.
- Filters: Optional criteria to identify specific attributes that trigger the reconciliation process. These also operate under a default-deny policy and require whitelisting.

## Own resource

Reconcilers may define own resources—those they create, update, or delete as a result of their business logic. These resources are often referred to as child resources.

```yaml
  owns:
  - group: req.kuid.dev
    version: v1alpha1
    kind: Attachment
```

Parameters:

	•	GVK (Group, Version, Kind): Identifies the own resource.

When the business logic creates child resources it uses owner referernces and finalizers parameters on the child resources:
- Owner References are used to track resources created by the reconciler, ensuring that dependency relationships are maintained.
- Finalizers are used to allow the reconciler to perform necessary clean-up tasks before the child resource is fully removed from the system.

!!!note "Filtering mechanisms are omitted for owneed resources given there is an explicit parent relationship using onwer references."

## Reocnciler config example

Below is a practical example of how to define a reconciler configuration in `Choreo`. This configuration specifies how the reconciler interacts with various resources, utilizing the for, owns, and watches clauses to manage relationships and dependencies effectively.

```yaml
apiVersion: choreo.kform.dev/v1alpha1
kind: Reconciler
# name can be inferred from the filename or from the for resource
spec: 
  for: 
    group: nf.nephio.org
    version: v1alpha1
    kind: NFDeployment
    selector:
      match:
        spec.provider: upf.free5gc.io
  owns:
  - group: req.kuid.dev
    version: v1alpha1
    kind: Attachment
  - group: req.kuid.dev
    version: v1alpha1
    kind: Prefix
  watches:
  - group: req.nephio.org
    version: v1alpha1
    kind: Capacity
    selector:
      match:
        metadata.name: upf
  - group: req.nephio.org
    version: v1alpha1
    kind: Interface
    selector:
      match:
        metadata.name: n3
  - group: req.nephio.org
    version: v1alpha1
    kind: Interface
    selector:
      match:
        metadata.name: n4
  - group: req.nephio.org
    version: v1alpha1
    kind: Interface
    selector:
      match:
        metadata.name: n6
```

## filtering example using cel expressions

This example shows

```yaml
    selector:
      match:
        status.conditions.exists(c, c.type == 'Ready' && c.status == 'True'): "true"
```