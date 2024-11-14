# get_subnetname

**Builtin function**

`get_subnetname(prefix)`

**Description**

Return a name of a prefix.

**Parameters**

- `prefix` (string): The IP prefix.

**Returns**

`string`: Returns a string using the prefix and prefix length.

**Example**

```python
name = get_prefixlength("10.0.0.1/24")
print(name)  # Output: 10.0.0.1_24
```