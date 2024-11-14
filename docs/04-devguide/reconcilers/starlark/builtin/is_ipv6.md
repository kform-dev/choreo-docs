# ip_ipv6

**Builtin function**

`is_ipv6(prefix)`

**Description**

Checks if the given `prefix` is an IPv6 prefix.

**Parameters**

- `prefix` (string): The IP prefix to check.

**Returns**

`bool`: Returns `true` if the provided `prefix` is an IPv6 prefix; otherwise, it returns `false`.

**Example**

```python
result = is_ipv6("2001:0db8:85a3:0000:0000:8a2e:0370:7334/128")
print(result)  # Output: true

result = is_ipv6("192.168.1.1")
print(result)  # Output: false
```