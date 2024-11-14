# client_get

**Builtin function**

`client_get(name, namespace, resource)`

**Description**

Gets a resource from the apiserver using name, namespace and resource identifier.

**Parameters**

- `name` (string): The name of the resource.
- `namespace` (string): The namespace of the resource.
- `resource` (string): The resource with apiVersion and Kind.

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
resource = get_resource("ipam.be.kuid.dev/v1alpha1", "IPClaim")
rsp = client_get(name, namespace, resource["resource"])
if rsp["error"] != None:
  # error path
# ok path
```