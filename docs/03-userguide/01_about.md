# About

`Choreo` is an innovative tool designed to bridge the gap between development and production environments through a unified technology framework. Equipped with both server-side and client-side components, `Choreo` facilitates seamless transitions from development to production, making it an indispensable tool for dynamic application environments.

## Dual-Environment Functionality

`Choreo` excels in both development (`dev`) and production (`prod`) settings. In development, users can evolve and update a base reference, continually refining their use cases with new data or business logic. In production, `Choreo` operates using a predefined reference, executing established logic with high reliability and consistency.

## Key Components

### server

The `Choreo` server can be initiated in two primary modes:

- `User Mode`: This mode is tailored for users who prefer hands-on control over their project environments. Users manually clone a project and direct the Choreo server to the project directory upon startup. This mode fully supports version control operations, allowing users to commit, stash, push, and manage their changes using e.g. standard git commands. It is ideal for developers who need to interact directly with their codebase and version history.
- `Choreo Mode`: Designed for automated efficiency, this mode enables the server to autonomously manage project directories. It clones repositories based on an immutable reference, suiting both manual interventions and automated processes. While it simplifies repository operations, it still supports a subset of essential version control functions, making it suitable for scenarios where streamlined, consistent deployments and updates are crucial.

### runner

`Choreo`’s runner operates in two distinct modes, catering to different operational needs:

- `Dev Mode`: Tailored for development tasks, this mode handles specific operations, executing them to completion and allowing for iterative testing and development. The dev mode is used to test new data input or changing reconciler logic.
- `Prod Mode`: Designed for production, this mode enables the runner to continuously process and react to events with its built-in reconciler logic, ideal for monitoring and observing ongoing activities within the environment.

### result manager

Results from operations are meticulously captured in conditions and stored in snapshots at the end of each run, providing a persistent and immutable record of system states and data outputs. In continuous prod mode, the server must be stopped to finalize and store results, facilitating comprehensive comparisons through diffs between successive runs.

More details will be explained in the respective sections of the user guide.