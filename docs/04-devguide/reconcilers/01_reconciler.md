# Reconciler Introduction

In `Choreo`, `reconcilers` are essential components that synchronize the desired state of resources with their actual state in the system. They are tightly integrated with the API server, responding to changes in resources and executing their corresponding business logic.  

When configuring a reconciler in Choreo, developers define two crucial aspects:

- Attachment Specifications: Specifies which resources or resource types the reconciler attaches to within the system.
- Business Logic: Dictates how the reconciler responds to changes, including the transformations it applies to resources.

The attachment is detailed in the reconciler configuration, while the business logic is implemented in the language of the developer’s choice.

## Reconciler Configuration

Reconcilers in Choreo attach to resources using event handlers, enabling specific interactions based on the resource type:

- For Resource: This is the primary resource that the reconciler manages directly. Each instance of this resource is handled in its own Go routine, ensuring isolated and efficient management.
- Watch Resource: These are the resources that the reconciler depends on for executing its logic. Changes in these resources can trigger the reconciler to act on the primary resource. Examples of watch resources are templates or external source of data
- Own Resource: These are resources that the reconciler creates as a result of its operations. Managing these resources involves tracking dependencies and cleanup via owner references and finalizers. 

## Reconciler Logic

Reconcilers are designed to be idempotent and language-agnostic, allowing for diverse implementation strategies. In `Choreo` we aim for ease of use to optimize the development experience.

Managing the complete lifecycle of resources—such as creation, updates, and cleanup—can be complex, often requiring developers to handle intricate historical data and state changes. Choreo simplifies this aspect of reconciler implementation by abstracting the historical management of resources, allowing developers to focus solely on specifying the desired state of resources based on current context.

## Reconciler Outcomes

The actions a reconciler can take in response to events include:

- Done: The reconciler has completed its task with no further actions required.
- Requeue: The resource needs to be rechecked and possibly reconciled again in the near future.
- Requeue After: Similar to Requeue, but with a delay specified before the resource is reconsidered.
- Error: Indicates an issue during reconciliation; this typically leads to an implicit requeue unless handled otherwise.
- Fatal: A severe error that may require manual intervention or halt further automatic reconciliation under certain conditions.

## Conflict resolution

To address potential conflicts between multiple reconcilers acting on the same resource, Choreo utilizes server-side apply logic. This approach ensures that each resource parameter is uniquely managed by a specific reconciler, thereby preventing operational overlap and conflicting modifications.

!!!note "Developer Considerations: A developper when designing the system has to ensure a resource parameter is only owned by a given reconciler"

