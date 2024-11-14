# get_address

**Builtin function**

`get_address(prefix)`

**Description**

Return a the ip address of the prefix.

**Parameters**

- `prefix` (string): The IP prefix.

**Returns**

`string`: Returns the ip address of the prefix.

**Example**

```python
address = get_address("10.0.0.1/24")
print(address)  # Output: 10.0.0.1
```