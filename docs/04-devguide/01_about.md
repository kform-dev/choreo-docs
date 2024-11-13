# Developer guide

The developper guide is designed to help developers extend Choreo with custom APIs and custom business logic (reconcilers) for their use cases.

## APIs

At the heart of `Choreo` are its APIs, which are implemented using Custom Resource Definitions (CRDs). These CRDs extend Choreo’s native capabilities, allowing developers to define custom resources specific to their needs. Each API in Choreo is designed to be self-descriptive and aligned with standard KRM practices, ensuring ease of use and integration.

## Reconcilers

Reconcilers are another pivotal component of `Choreo`. They attach to a resource in Choreo and react to resource changes triggering necessary updates and adjustments based on their business logic. Choreo support the following reconciler types right now.

- python/starlark
- go template
- jinja2 template
