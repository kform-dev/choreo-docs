# is_conditionready

**Builtin fucntion**

`is_conditionready(resource, condition_type)`

**Description**

Checks if the given `resource` condition with the  `conditionType` is true or false.

**Parameters**

- `resource` (dict): The resource used to check the condition status.
- `condition_type` (string): The condition type

**Returns**

`bool`: Returns `true` if the provided `resource` condition with conditionType is `true`

**Example**

```python
if is_conditionready(self, "IPClaimReady") != True:
  # false path
# true path
```