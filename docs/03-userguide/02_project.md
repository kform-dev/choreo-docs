# Project

A `Choreo` project organizes resources within a directory structure designed to streamline the management and deployment of the automation logic. A typical `Choreo` package contains four main sub-directories: `crds`, `reconcilers`, `in`, and `refs` that define together your automation logic.

Directory breakdown

- CRDs (`crds`): This directory houses all external APIs and any associated libraries, complete with getters and setters, defining the schemas for resource validation and manipulation.
- Reconcilers (`reconcilers`): Stores the business logic, or reconcilers, each within its own subdirectory. This includes both the configuration files and the executable logic responsible for your automation logic.
- Input Data (`in`): This directory contains all input data that drives business logic within the project.
- References (`refs`): Maintains links to child Choreo packages, which may include additional CRDs, business logic, or data, enabling modular project expansion and reuse.


`Choreo` operates within the context of a root package, typically the working directory from which the Choreo CLI is invoked. This root package may incorporate an entire configuration hierarchy, including child packages defined via upstream references.

## APIs and API extensions

`Choreo` supports cutomizing resources through Custom Resource Definitions (CRDs), allowing users to define custom schemas for their automation environment. Projects can incorporate CRDs directly within the crds directory or through external references to repositories. These CRDs establish the structural schemas for resources (APIs), enhancing the system’s adaptability to specific resources for your automation.

## Reconcilers

Reconcilers are central to your automation functionality, defining the business logic applied to resources for your use case. Each reconciler specifies:

- A unique name.
- A conditionTyoe used to reflect the status of the business logic outcome in a condition.
- The resources it targets (for, own, watch resources)
- The business logic for the use case.

`Choreo` promotes a “low-code/no-code” philosophy, aiming to simplify the user experience and broaden accessibility. Supported languages for reconciler definitions include:

- Starlark (python)
- Jinja2 templates
- Go templates

## UpstreamRefs

`Choreo` allows for reusable packages accross multiple project through the use of upstream refs. An upstream ref is basically a child `Choreo` instance of a root `Choreo` package. 

## Data (Input)

Besides the built-in choreo apis, input data can also be provided in a choreo package. The input data, aligned with the API definitions, get invoked and will trigger the reconciler business logic defined in the `Choreo` instance.