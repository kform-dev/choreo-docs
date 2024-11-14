# reconcile_result

**Builtin function**

`reconcile_result(resource, )`

**Description**

Create a resource as a result of the reconciler logic. This function does not immediately apply the resource to the apiserver but rather registers the resource in the reconciler resource list, that choreo will apply once the reconciler returns a successfull reconcile result.

**Parameters**

- `resource` (dict): The KRM resource.
- `requeue` (bool): requeue parameter indicates if the reconciler should requeue
- `requeue` (int64): requeue timeout if any
- `error` (string): error message of the reconciler result
- `fatal` (bool): fatal indicates if the reconciler result is fatal

**Returns**

finishes the reconciler process

**Example**

```python
return reconcile_result(self, False, 0, "", False)
```