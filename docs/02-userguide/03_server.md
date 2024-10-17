# Choreo Server

The Choreo server initiates with two distinct operational modes: User Mode and Choreo Mode. Each mode is designed to support various development and production needs, ranging from full user control to automated environment management.

- User Mode: Provides developers with full control over the project environment, allowing direct interaction with the repository and its version control systems.
- Choreo Mode: Automates project management tasks, enabling dynamic context management with minimal user intervention.

These modes enable tailored workflows, accommodating both hands-on development practices and streamlined, automated operations for production environments.

## Starting the server

To start the Choreo server, use the following command format:

```bash
choreo server start [DIRECTORY] [flags]
```

The presence of a directory argument in the command determines the operational mode of the server:

- User Mode: Specify the directory to activate this mode.
- Choreo Mode: Omit the directory to operate in Choreo Mode.

## User Mode

### Overview

In `User Mode`, the user manually clones a repository and points the Choreo server to either the cloned directory or a subdirectory within it. This mode is primarily used for development, where developers require full control over the version control operations.

### Operations

To start the server in User Mode, specify the directory path:

```bash
choreo server start [DIRECTORY] [flags]
```

In this mode, the context of the server is fixed to the specified directory, but the user retains the ability to use all version control commands, such as commit, stash, and push. This facilitates an interactive development process where changes can be directly managed and integrated.


## Choreo Mode

### Overview

Choreo Mode allows the server to dynamically manage the project’s context. When provided with a repository URL, directory path, and reference, the server autonomously handles the cloning and setup of the repository in a specific directory. This mode supports both development and production environments.

### Operations

To configure the server in Choreo Mode, use the apply command with the necessary repository details:

```bash
choreo server apply [URL] [DIR] [REF] [BRANCH]
```

### Mode Differentiation

- Development Environment: Specify a branch to indicate that the server should operate in development mode. In this mode, the user or automated systems can instruct the server when to run operations, commit changes, push updates, and create diffs.
- Production Environment: Omit the branch to default to production mode, typically using the main branch. In this setting, the server operates in a continuous mode, executing the reconciliation logic referenced in the project

### Dynamic Context Switching

you can switch context to the server using the following comamnd. We don`t expect people to switch between production or development, but e.g. in production we can change the reference to rollback to a previous reference that was more stable or to move to a new reference that was validated. In development we will see people commiting chnages to a new branch for new changes to the repo.

```bash
choreo server apply [URL] [DIR] [REF] [BRANCH]
```

### Status Retrieval

To retrieve the current status or configuration of the server, use the get command:

```bash
choreo server get
```

This command is essential for monitoring and managing the server’s state, ensuring transparency and control over the ongoing processes.