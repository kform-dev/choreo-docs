# get_prefixlength

**Builtin function**

`get_prefixlength(prefix)`

**Description**

Return the get_prefixlength of a prefix.

**Parameters**

- `prefix` (string): The IP prefix.

**Returns**

`int`: Returns the prefixLength of the prefix.

**Example**

```python
prefix_length = get_prefixlength("2001:0db8:85a3:0000:0000:8a2e:0370:7334/128")
print(prefix_length)  # Output: 128
```