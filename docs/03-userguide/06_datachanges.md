# Managing Data Changes

In Choreo, you can update the system’s input using the choreoctl apply command. This command allows you to apply configuration changes directly from a YAML file, facilitating the dynamic modification of resources.

## Applying Changes

To change the input data, you can use the following command, which feeds the YAML data directly into choreoctl:

```yaml
choreoctl apply -f - <<EOF
apiVersion: topo.kubenet.dev/v1alpha1
kind: Topology
metadata:
  name: kubenet
  namespace: default
spec:
  defaults:
    provider: srlinux.nokia.com
    platformType: ixrd3
    version: 24.7.2
    region: region1
    site: us-east
  nodes:
  - name: node1
  - name: node2
  - name: node3
  - name: node4
  links:
  - endpoints:
    - {node: node1, port: 1, endpoint: 1, adaptor: "sfp"}
    - {node: node2, port: 1, endpoint: 1, adaptor: "sfp"}
  - endpoints:
    - {node: node2, port: 2, endpoint: 1, adaptor: "sfp"}
    - {node: node3, port: 2, endpoint: 1, adaptor: "sfp"}
  - endpoints:
    - {node: node3, port: 1, endpoint: 1, adaptor: "sfp"}
    - {node: node4, port: 1, endpoint: 1, adaptor: "sfp"}
  - endpoints:
    - {node: node4, port: 2, endpoint: 1, adaptor: "sfp"}
    - {node: node1, port: 2, endpoint: 1, adaptor: "sfp"}
EOF
```


## Developer Mode:

In Developer Mode, you must execute the `choreoctl run once` to apply the data. Th apply command does not immediately apply changes to the live API but adds or modifies files in the input directory after validating the data against the schema.

You can also manually edit, add, or delete files in the input directory to manage your configurations. This flexibility allows developers to experiment and test changes locally before they are pushed to production.

## Production Mode:

In Production Mode, changes applied via choreoctl are immediately validated and integrated into the live system environment, ensuring that updates are propagated in real-time. 