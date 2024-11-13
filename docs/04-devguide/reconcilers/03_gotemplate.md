# Reconciler Using Go Templates

This chapter explains how to develop a reconciler using [Go templates](go template), tools for transforming primary resources into child resources based on the input data. We will cover setting up the reconciler configuration and defining the business logic using [Go templates](go template).

## Reconciler config

First, define the reconciler configuration. [Go templates](go template) act as transformers that attach to a primary resource and generate a new child resource based on the input data. Specify the GVK (Group, Version, Kind) of both the primary and the child resources in your configuration. You can use additional filters to target transformations on resources with specific parameters.

In the example below, only interfaces with spec.provider equal to srlinux.nokia.com will be transformed.

```yaml
apiVersion: choreo.kform.dev/v1alpha1
kind: Reconciler
metadata:
  name: interfaces.device.network.kubenet.dev.srlinux.nokia.com
spec: 
  conditionType: Ready
  for: 
    group: device.network.kubenet.dev
    version: v1alpha1
    kind: Interface
    selector: 
      match:
        spec.provider: srlinux.nokia.com
  owns:
  - group: config.sdcio.dev
    version: v1alpha1
    kind: Config
```

Details:

- For Resource (for): Specifies the primary resource to which the reconciler attaches.
- Owns: Defines the type of child resource the reconciler will generate.
- Selector: Provides filtering capabilities to specify which resources with particular parameters will be transformed.


## Go Template Business Logic

Next, define your reconciler’s business logic as a Go template. The logic can be split across multiple files, but a main file ending with .main.tpl is required. Subsequent files can have any suffix and are referenced within the main template.

We recommed using the following structure for the filenames:

`<name>.tpl`

## Example

Here’s an example of a Go template that creates a Config resource from an Interface resource:

Main template:` main.tpl`

```yaml
apiVersion: config.sdcio.dev/v1alpha1
kind: Config
metadata:
  name: {{ .metadata.name }}
  namespace: {{ .metadata.namespace }}
  labels:
    config.sdcio.dev/targetName: {{ .spec.node }}
    config.sdcio.dev/targetNamespace: {{ .metadata.namespace }}
spec:
  priority: 10
  config:
  - path: /
    value: 
{{- template "srlinterface" .spec}}
```

Sub Template: `interface.tpl`

Here’s an example of a sub-template defined in a separate file, which is referenced in the main template:

```yaml
{{- define "srlinterface"}}
      interface:
      - name: {{ .name }}
        description: k8s-{{ .name }}
        admin-state: enable
      {{- if .vlanTagging}}
        vlan-tagging: true
      {{- end}}
{{- end }}
```

Explanation:

- Metadata and Spec Configuration: Uses placeholders to dynamically set values based on the primary resource’s properties.
- Template Call: {{- template "srlinterface" .spec}} calls a defined sub-template that sets additional configuration based on the Interface spec.

Template-based reconcilers support modular and reusable logic, enabling developers familiar with this technology to efficiently leverage existing templates or adapt them for new applications.

[go template]: https://pkg.go.dev/text/template