# Reconciler Config

In Choreo, a reconciler configuration is defined within a reconciler resource, where developers specify their specific parameters for their usecase. This configuration determines how the reconciler interacts with the system’s resources.

```yaml
apiVersion: choreo.kform.dev/v1alpha1
kind: Reconciler
```

### Name

Each reconciler should be given a unique name, we recommend using the following convention.

`<resource name>.<group>.<unique id>`

e.g.

```yaml
metadata:
  name: helloworlds.example.com.hello-world
```

where:

- resource name: helloworlds
- group: example.com
- unique id: hello-world

!!! Note "changing the name of a reconciler once it has executed it business logic can lead to conflicting information, If you have to do so remove the db folder from your environment"

### Condition

Conditions are used to reflect the status of the reconcilation. Given we can have multiple reconcilers on a primary resource, each doing a specific thing, conditions need to be uniquely identified through a conditionType. 

Conditions are identified using the following parameters, However as a developer the only thing you have to worry about is uniqueness of a conditionType within a given resource for a given resonciler.

```yaml
conditions:
- lastTransitionTime: "2024-11-12T11:01:36Z"
  message: ""
  reason: Ready
  status: "True"
  type: IPClaimReady
```

!!! Note "changing the conditionType of a reconciler once it has executed it business logic can lead to conflicting information, If you have to do so remove the db folder from your environment"

### For Resource hook

The for resource hook is mandatory and identifies the primary resource that the reconciler manages. It is sometimes referred to as the primary resource. A For resource is mandatory in a reconciler config

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

## Own resource hook

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

!!!note "Filtering mechanisms are omitted for owneed resources given there is an explicit parent relationship using owner references."

## Reconciler config example

Below is a practical example of how to define a reconciler configuration in `Choreo`. This configuration specifies how the reconciler interacts with various resources, utilizing the for, owns, and watches clauses to manage relationships and dependencies effectively.

```yaml
apiVersion: choreo.kform.dev/v1alpha1
kind: Reconciler
metadata:
  name: nodes.infra.kuid.dev.itfce
spec: 
  conditionType: InterfaceReady
  for: 
    group: infra.kuid.dev
    version: v1alpha1
    kind: Node
    selector:
      match:
        status.conditions.exists(c, c.type == 'IPClaimReady' && c.status == 'True'): "true"
  owns:
  - group: device.network.kubenet.dev
    version: v1alpha1
    kind: Interface
  - group: device.network.kubenet.dev
    version: v1alpha1
    kind: SubInterface
  watches:
  - group: ipam.be.kuid.dev
    version: v1alpha1
    kind: IPIndex
    selector:
      match:
        metadata.name: kubenet.default
        status.conditions.exists(c, c.type == 'Ready' && c.status == 'True'): "true"
```

## Filtering example using cel expressions

This example shows how to match on a resource only when the conditionType == Ready and the status == True

```yaml
    selector:
      match:
        status.conditions.exists(c, c.type == 'Ready' && c.status == 'True'): "true"
```