# Reconciler hooks

In Choreo, reconcilers are critical components that synchronize the desired state of resources with their actual state in the system. They are tightly integrated with the API server, responding to changes in resources and executing their respective business logic.  

## Reconciler Attachments

Reconcilers are attached to specific resources within Choreo using event handlers, and they operate based on several key principles:

- For Resource: This is the primary resource that the reconciler manages directly. Each instance of this resource is handled in its own Go routine, ensuring isolated and efficient management.
- Watch Resource: These are the resources that the reconciler depends on for executing its logic. Changes in these resources can trigger the reconciler to act on the primary resource.
- Own Resource: These are resources that the reconciler creates as a result of its operations. Managing these resources involves tracking dependencies and cleanup via owner references and finalizers.

Reconcilers are designed to be idempotent and language-agnostic, allowing for diverse implementation strategies and ease of use.

## Configuration of Reconcilers

### For Resource

The primary resource for a reconciler is specified with mandatory fields that define what resource it manages:

```yaml
for: 
  group: nf.nephio.org
  version: v1alpha1
  kind: NFDeployment
  selector:
    match:
      spec.provider: upf.free5gc.io
```

- Mandatory Configuration: The reconciler is attached to a single resource type, and changes to any instance of this resource can trigger the reconciler.
- Filters: Filters can be applied to select specific resources based on any field within the resource. Filters are implemented using cel functionality to allow for very flexible filtering logic.


## Watch resource

Watching resources is optional but crucial for reconcilers that rely on external data or dependencies:

- Trigger Mechanism: A change in any watched resource can initiate a reconciliation process for the associated primary resource.
- Dependency Management: This setup allows a reconciler to monitor resources that impact its logic or outcomes.

```yaml
  watches:
  - group: req.nephio.org
    version: v1alpha1
    kind: Capacity
    selector:
      match:
        metadata.name: upf
```

Watch resources allow for the extensive filtering mechanism

## Own resource

Managing owned resources involves utilizing KRM features like owner references and finalizers:

- Owner References: These are used to track resources created by the reconciler, ensuring that dependency relationships are maintained.
- Finalizers: Utilized to clean up resources when they are deleted, allowing the reconciler to perform necessary clean-up tasks before the resource is fully removed from the system.

```yaml
  owns:
  - group: req.kuid.dev
    version: v1alpha1
    kind: Attachment
```

Filtering mechanisms are omitted for owneed resources given there is an explicit parent relationship using onwer references.

## Reconciler Outcomes

The actions a reconciler can take in response to events include:

- Done: The reconciler has completed its task with no further actions required.
- Requeue: The resource needs to be rechecked and possibly reconciled again in the near future.
- Requeue After: Similar to Requeue, but with a delay specified before the resource is reconsidered.
- Error: Indicates an issue during reconciliation; this typically leads to an implicit requeue unless handled otherwise.
- Fatal: A severe error that may require manual intervention or halt further automatic reconciliation under certain conditions.


## Conflict resolution

Choreo employs server-side apply logic to resolve conflicts between reconcilers acting on the same resource. This ensures that each parameter of a resource is uniquely managed by a specific reconciler, avoiding overlap and conflicting operations.

## Simplifying implementation

Managing the complete lifecycle of resources—such as creation, updates, and cleanup—can be complex, often requiring developers to handle intricate historical data and state changes. Choreo simplifies this aspect of reconciler implementation by abstracting the historical management of resources, allowing developers to focus solely on specifying the desired state of resources based on current context.

## Example

Below is a practical example of how to define a reconciler configuration in Choreo. This configuration specifies how the reconciler interacts with various resources, utilizing the for, owns, and watches clauses to manage relationships and dependencies effectively.

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