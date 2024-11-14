# Reconciler using Starlark

This chapter explains how to develop a reconciler using [Starlark](Starlark), a dialect of [Python](Python).

## Reconciler config

Begin by defining the reconciler configuration as detailed in the [reconciler config chapter](../02_config.md). This configuration sets up the environment and parameters with which your Starlark reconciler will operate.

## Business logic

### Entry Function

In Starlark, the entry point for reconciler logic is a function named `reconcile`. This function is automatically invoked by the Choreo framework once an event occurs on the primary resource instance defined in the reconciler config.

```python
def reconcile(self):
```

### Reconciliation Logic

The reconcile function contains the business logic depending on the desired state of the resource. The reconciliation logic must be idempotent; it must produce the same results when run multiple times with the same input. 

Choreo automatically manages resources change management, so your reconciler should define outcomes based on the current status. Any updates or deletions of child resources are handled by Choreo according to your resource configurations.


### Reconciler Exit

The exit of the reconciler function should return a result that indicates whether the reconciliation was successful, and any actions to be taken by the Choreo framework:

```python
return reconcile_result(self, requeue=False, requeueAfter=0, err_msg="", fatal=False)
```

### Libraries

Using libraries enhances code reusability and simplifies the development of complex logic within reconcilers. Libraries allow developers to encapsulate common functionalities, which can be shared across various components of the project or even between different projects.

In Choreo, libraries related to API resources are stored alongside the CRD in the crds directory using the same crd name, but using the `.star` extension. Choreo detects these libraries during project loading. Reconcilers can then reference specific library functions as needed:

```python
load("topo.kubenet.dev.topologies.star", "build_node", "build_link")
```

## Example

```python
def reconcile(self):
  # self = krm resource instance

  # business logic
  
  return reconcile_result(self, False, 0, "", False)
```


[Starlark]: https://github.com/bazelbuild/starlark
[Python]: https://www.python.org