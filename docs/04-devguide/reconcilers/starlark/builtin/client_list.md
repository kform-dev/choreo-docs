# client_list

**Builtin function**

`client_list(resource, fieldSelector)`

**Description**

List resources from the apiserver using a resource identifier and field selector.

**Parameters**

- `resource` (string): The resource with apiVersion and Kind.
- `field selector` (dict): The key value match expression.

**Returns**

`result`: as a dict with the following keys

**Key: `resource`**
- **Type**: `None` or relevant KRM object as a `dict`
- **Description**: This key holds the resource associated with the operation, if applicable. If the operation did not involve a specific resource, or if the resource is not applicable, this key will contain `None`.

**Key: `error`**
- **Type**: `string`
- **Description**: Provides a textual description of the error encountered, if any. In cases where the operation completes successfully, this might be empty or a message indicating no error.

**Key: `fatal`**
- **Type**: `bool`
- **Description**: Indicates whether the operation encountered a fatal error. A value of `true` implies a serious error that likely halted the operation, while `false` indicates no fatal errors were encountered.


**Example**

```python
fieldSelector = {}
fieldSelector["spec.partition"] = spec.get("partition", "")
fieldSelector["spec.region"] = spec.get("region", "")
fieldSelector["spec.site"] = spec.get("site", "")
fieldSelector["spec.node"] = spec.get("node", "")

silist = get_resource("device.network.kubenet.dev/v1alpha1", "SubInterface")
rsp = client_list(silist["resource"], fieldSelector)
if rsp["error"] != None:
  # error path
# ok path
```