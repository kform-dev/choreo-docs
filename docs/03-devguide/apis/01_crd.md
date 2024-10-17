# API(s)

Choreo adopts an API-first approach, fundamentally leveraging the [Kubernetes Resource Model (KRM)][KRM] as defined by Kubernetes. In this system, each API object represents a resource that Choreo imports using [Custom Resource Definitions (CRDs)][CRD]. CRDs allow for the extension of Choreo's capabilities by defining new resource types with associated schemas.

## Defining a CRD

You can create a CRD in various ways:

- manually
- [kubebuilder](./02_kubebuilder.md)
- others: TBD 

Each CRD includes several critical pieces of metadata that define how the resource interacts with the API Server:

- Group: The API group to which the CRD belongs, helping to categorize and control API extensions.
- Kind: The type of the resource, which is typically a descriptive name in CamelCase.
- Version: Indicates the version of the API which can evolve over time.
- Scope: Determines whether the resource is Namespaced (available within specific namespaces) or Cluster-scoped (available across all namespaces).
- Names: Includes the plural, singular, and optionally short names used in API requests and user interfaces.

### CRD example

Here is an example of a CRD definition for a custom resource named “CronTab”:

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  # name must match the spec fields below, and be in the form: <plural>.<group>
  name: crontabs.stable.example.com
spec:
  # group name to use for REST API: /apis/<group>/<version>
  group: stable.example.com
  # list of versions supported by this CustomResourceDefinition
  versions:
    - name: v1
      # Each version can be enabled/disabled by Served flag.
      served: true
      # One and only one version must be marked as the storage version.
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                cronSpec:
                  type: string
                image:
                  type: string
                replicas:
                  type: integer
  # either Namespaced or Cluster
  scope: Namespaced
  names:
    # plural name to be used in the URL: /apis/<group>/<version>/<plural>
    plural: crontabs
    # singular name to be used as an alias on the CLI and for display
    singular: crontab
    # kind is normally the CamelCased singular type. Your resource manifests use this.
    kind: CronTab
    # shortNames allow shorter string to match your resource on the CLI
    shortNames:
    - ct
```

Key Components of a CRD:

- API Version and Kind: Identifies the CRD in the context of the Kubernetes API.
- Metadata Name: Specifies the name of the CRD in a format <plural>.<group>.
- Spec: Defines the group, versions, and scope of the CRD, including the schema used to validate each version.
- OpenAPI Schema
    Embedded within the CRD is an openAPIV3Schema which specifies the structure and validation rules of the resource. This schema ensures that all instances of the resource conform to the defined specifications, such as required fields, field types, and additional metadata.

## CRD Usage in Choreo

In Choreo a CRD is stored in the crd folder of a project and will be imported when the choreo server starts. Once loaded CRUD operations can be performed on these resources.


[KRM]: https://github.com/kubernetes/design-proposals-archive/blob/main/architecture/resource-management.md
[CRD]: https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/ 
