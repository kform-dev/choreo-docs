# Choreo Server

The Choreo server can be started in two operational modes: `Static` Mode and `Dynamic` Mode. These distinct modes are designed to accommodate different workflows, allowing for both hands-on development and automated production operations.

## Static Mode

### Overview

`Static` Mode gives developers full control over the project environment. This mode is ideal for development settings where direct interaction with the repository and version control systems is necessary.

### Operations

In Static Mode, users are responsible for cloning the Choreo project repository and can choose their preferred technology for this task. Once started in this mode, the server’s project context remains fixed and cannot be changed dynamically.

To start the server in User Mode, specify the directory path:

```shell
choreo server start [DIRECTORY] [flags]
```

This mode allows full access to version control commands such as commit, stash, and push, facilitating an interactive development process.


## Dynamic Mode

### Overview

Dynamic Mode abstracts the management of the Choreo repository/package, handling the cloning and setup processes automatically. This mode is versatile, supporting both development and production environments where choreo managing the version control of the Choreo package.

### Operations

The below command shows how start the server in Dynamic Mode:

```bash
choreo server start [flags]
```

To dynamically configure the choreo package use the apply command with the necessary repository details:

```bash
choreo server apply [URL] [DIR] [REF] [BRANCH] [flags]
```

### Mode Differentiation

- Development Environment: Specify a branch to operate in development mode, allowing manual or automated system instructions for operations, commits, updates, and diffs.
- Production Environment: Omitting the branch defaults the server to production mode, typically utilizing the main branch for continuous operation.

### Dynamic Context Switching

Dynamic context switching is possible using the following command, which is useful for rolling back to a stable reference or advancing to a new validated reference:

```bash
choreo server apply [URL] [DIR] [REF] [BRANCH] [flags]
```

This feature is particularly valuable in production for quick rollbacks or in development for committing changes to a new feature branch.

### Status Retrieval

To check the current status or configuration of the server, use the get command:

```bash
choreo server get
```

This command is crucial for monitoring the server’s state and ensuring that all operations are transparent and under control.

## Server flags

- r (internal reconcilers): embed internal reconcilers, such as IPAM, VLAN, AS, GENID based resource handlers for claiming and registrating resource identifiers
- s (yang schema validation and config generation): use yang schema validation and config generation