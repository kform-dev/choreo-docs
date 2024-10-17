# Generating crds using kubebuilder

[Kubebuilder](kubebuilder) is a suite that simplifies building Kubernetes APIs using custom resource definitions ([CRDs](CRD)). It leverages Go structs along with controller-runtime annotations to automate and enhance the development process.

## Prerequisites

Before starting, ensure that Go is installed on your system. You can install Go by following the instructions here: Install [go](go)


## Setting Up Your Project

This section demonstrates setting up a basic project structure manually. Typically, this is scaffolded.


### Initialize the Project

Create and navigate into a new project directory:

```bash
mkdir <project-name>; cd <project-name>
git init -b main
mkdir -p apis/
```

initialize the go project

!!! note update the go mod file using your project information

```bash
go mod init github.com/dummy/test
```

### Prepare the Makefile


```bash
cat <<"EOF" > Makefile
## Location to install dependencies to
LOCALBIN ?= $(shell pwd)/bin
$(LOCALBIN):
	mkdir -p $(LOCALBIN)

## Tool Binaries
CONTROLLER_GEN ?= $(LOCALBIN)/controller-gen
CONTROLLER_TOOLS_VERSION ?= v0.15.0

# Setting SHELL to bash allows bash commands to be executed by recipes.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

.PHONY: manifests

all: manifests

.PHONY: manifests
manifests: controller-gen ## Generate WebhookConfiguration, ClusterRole and CustomResourceDefinition objects.
	mkdir -p artifacts
	$(CONTROLLER_GEN) rbac:roleName=manager-role crd paths="./apis/..." output:crd:artifacts:config=crds

.PHONY: controller-gen
controller-gen: $(CONTROLLER_GEN) ## Download controller-gen locally if necessary.
$(CONTROLLER_GEN): $(LOCALBIN)
	test -s $(LOCALBIN)/controller-gen || GOBIN=$(LOCALBIN) go install sigs.k8s.io/controller-tools/cmd/controller-gen@$(CONTROLLER_TOOLS_VERSION)
EOF
```

### Generate Manifests

```bash
make manifests
```

## Creating Your First API

create a directory where we store your api artifacts

```bash
mkdir -p apis/foo/v1alpha1
```

create a doc.go file and the test_types.go file containing the api


```bash
cat <<"EOF" > apis/foo/v1alpha1/doc.go
// +kubebuilder:object:generate=true
// +groupName=foo.example.com
// Package v1alpha1 is the v1alpha1 version of the API.
package v1alpha1
EOF
```

```bash
cat <<"EOF" > apis/foo/v1alpha1/test_types.go
package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// TestSpec defines the desired state of the Test resource
type TestSpec struct {
}

// TestStatus defines the observed state of the Test resource
type TestStatus struct {
}

// +kubebuilder:object:root=true
// +kubebuilder:subresource:status
// Test is the Schema for the Test API
type Test struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   TestSpec   `json:"spec,omitempty"`
	Status TestStatus `json:"status,omitempty"`
}

// TestList contains a list of Tests
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
type TestList struct {
	metav1.TypeMeta `json:",inline" yaml:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []Test `json:"items"`
}
EOF
```

run go mod tidy to resolve the dependencies

```bash
go mod tidy
```

generate your api

```bash
make manifests
```

start the server

```bash
choreoctl server start .
```

```bash
choreoctl apply <<EOF
apiVersion: foo.example.com/v1alpha1
kind: Test
metadata:
  name: my-first-test
EOF
```


## Adding parameters with validation

[crd generation](crd generation)

[crd validation](crd validation)


```go
type TestSpec struct {
    // +kubebuilder:validation:MaxLength=15
    // +kubebuilder:validation:MinLength=3
	// FieldA defines the name of field A
    FieldA string `json:"fieldA,omitempty"`
}
```

create an object with an empty fieldA in spec -> acceppted

```yaml
choreoctl apply <<EOF
apiVersion: foo.example.com/v1alpha1
kind: Test
metadata:
  name: my-first-test
spec:
EOF
```

create an object with a fieldA but with 1 char in spec -> rejected

```yaml
choreoctl apply - <<EOF
apiVersion: foo.example.com/v1alpha1
kind: Test
metadata:
  name: my-first-test
spec:
  fieldA: w
EOF
```

create an object with a fieldA but with 3 char in spec -> accepted

```yaml
kubectl apply -f - <<EOF
apiVersion: foo.example.com/v1alpha1
kind: Test
metadata:
  name: my-first-test
spec:
  fieldA: wim
EOF
```

## Examples of additional parameters with constraints

```go
type TestSpec struct {
    // +kubebuilder:validation:MaxItems=2
    // ListA defines a list of A
    ListA []string `json:"listA,omitempty"`

    // +kubebuilder:validation:Enum=unknown;gnmi;netconf;noop;ssh;
    // +kubebuilder:default:="gnmi"
    // Protocol defines the protocol to connect to the device
    Protocol string `json:"protocol"`

    // +kubebuilder:validation:Pattern=`(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])|((:|[0-9a-fA-F]{0,4}):)([0-9a-fA-F]{0,4}:){0,5}((([0-9a-fA-F]{0,4}:)?(:|[0-9a-fA-F]{0,4}))|(((25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])))`
    // Address defines the ip address to connect to the host
    Address string `json:"address"`

    // +kubebuilder:validation:Minimum=1
    // +kubebuilder:validation:Maximum=200
    // +kubebuilder:default:=100
    Priority   *uint8 `json:"priority,omitempty"`
}
```

[go]: https://go.dev/doc/install
[crd generation]: https://book.kubebuilder.io/reference/generating-crd
[crd validation]: https://book.kubebuilder.io/reference/markers/crd-validation
[kubebuilder]: https://book.kubebuilder.io/introduction
[crds]: https://book.kubebuilder.io/reference/generating-crd