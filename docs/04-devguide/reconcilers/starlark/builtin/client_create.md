# client_create

**Builtin fucntion**

`client_create(resource)`

**Description**

Create a resource as a result of the reconciler logic. This function does not immediately apply the resource to the apiserver but rather registers the resource in the reconciler resource list, that choreo will apply once the reconciler returns a successfull reconcile result.

**Parameters**

- `resource` (dict): The resource to be created.

**Returns**

`result`: as a dict with the following keys

**Key: `resource`**
- **Type**: `None` or relevant KRM object
- **Description**: This key holds the resource associated with the operation, if applicable. If the operation did not involve a specific resource, or if the resource is not applicable, this key will contain `None`.

**Key: `error`**
- **Type**: `string`
- **Description**: Provides a textual description of the error encountered, if any. In cases where the operation completes successfully, this might be empty or a message indicating no error.

**Key: `fatal`**
- **Type**: `bool`
- **Description**: Indicates whether the operation encountered a fatal error. A value of `true` implies a serious error that likely halted the operation, while `false` indicates no fatal errors were encountered.


**Example**

```python
rsp = client_create(itfce)
if rsp["error"] != None:
  # error path
# ok path
```