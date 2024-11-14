# get_resource

**Builtin function**

`get_resource(apiVersion, kind)`

**Description**

Gets a empty resource with the apiVersion and kind.

**Parameters**

- `apiVersion` (string): The apiversion of the resource.
- `kind` (string): The kind of the resource.

**Returns**

`resource`: a empty KRM resource with apiVersion and kind

**Example**

```python
resource = get_resource("ipam.be.kuid.dev/v1alpha1", "IPClaim")
```