# Project

A Choreo project is a collection of resources in the form of `.yaml` or `.yml` stored in a directory. `Choreo` uses 3 main sub-directories in a package called `crds`, `in` and `refs`. 

- The `crd` directory stores all the external API(s)
- The `in` directory stores all the `business logic` aka `programs` and `input data` associated with a project. 
- The `refs` directory stores all the references to child choreo packages that can include additional `crds`, `business logic` or `data`

`Choreo` always runs in the context of a single root package. A complete `Choreo` configuration consists of a root package and optionally a tree of child packages (if upstream references are referenced in the package)

In `Choreo` CLI, the root package is the working directory where `Choreo` is invoked/pointed at.

## APIs and API extensions

By using Custom resource definitions you can customize Choreo to orchestrate any use case. `CRDs` are stored in the `crd` directory of a choreo package and define the schema of the resource/api used to validate the resources consumed by the API. Choreo API is declarative 

## Reconcilers

Reconcilers define the business logic associated to a resources. When defining a reconciler you define 2 things:
- Which resources the reconciler is interested in.
- The reconciler business logic. 

Reconcilers in choreo are built with a `low code no code` approach in mind to ease the adoption of the system.

The following reconciler languages are supported:
- starlark
- gotemplates
- jinja2 templates

## Libraries

To allow for more reusable  

## UpstreamRefs

`Choreo` allows for reusable packages accross multiple project through the use of upstream refs. An upstream ref is basically a child `Choreo` instance of a root `Choreo` package. 

## Data

Besides the built-in choreo apis, input data can also be provided in a choreo package. The input data, aligned with the API definitions, get invoked and will trigger the reconciler business logic defined in the `Choreo` instance.