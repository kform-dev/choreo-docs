# Runner

The Choreo runner operates as the execution engine of the system, capable of running in two distinct modes: Development Mode and Production Mode. These modes are tailored to support different stages of project development and deployment.

## Resources

Choreo is fundamentally an API-first system, utilizing Kubernetes Resource Model (KRM) Custom Resource Definitions (CRDs) as APIs to manage and interact with resources. When the runner is initiated, it loads CRDs and input data from associated directories in the Choreo server. Following data initialization, reconcilers are instantiated to execute their business logic based on the updated resources in the system. This setup leverages a list and watch mechanism, allowing reconcilers to trigger and operate based on data.

## Developer mode

### Purpose

Development mode is designed for testing and validation, ideal for developers looking to verify new data inputs, API functionalities, or business logic changes. This mode provides an iterative environment where changes can be applied, tested, and observed in a controlled setting.

### Operation

In Development Mode, the runner operates on a single-run basis, executing the following steps:

1.	Initialization: Loads CRDs, librariers, reconciler logic and input data into the system. Potentially leveraging child choreo projects using upstream references.
2.	Execution: Starts the reconcilers which consume the data and execute the business logic based on resource changes using its event driven framework.
3.	Observation: An observer component monitors the execution process, assessing outcomes based on various indicators such as error messages, condition statuses, and event triggers.
4. Optionally when the -s flag was initiated a config validation and schema validation will be executed.

### Completion

The process concludes when the observer determines the success or failure of the run. The results are then presented to the developer, facilitating quick feedback and iteration.

```shell
choreoctl run once
```

```shell
loading ...
loading done
running reconcilers ...
running root reconciler hello-world
Run root summary
execution success, time(msec) 12.487ms
Reconciler                          Start Stop Requeue Error
helloworlds.example.com.hello-world 2     2    0       0    
completed
```

## Production mode

### Purpose

Production mode is designed for continuous operation, when you decided the input data and business logic is suitable for produciton.

### Operation

In Production Mode, the runner continuously processes and reacts to changes in the environment, driven by event triggers and updates to the resources:

1.	Start: Initializes and begins continuous processing.
2.	Running: Maintains ongoing observation and response to resource changes and system events.
3.	Management: Allows for stopping and starting of operations to manage updates or maintenance tasks effectively.

start the server in continuous mode

```bash
choreoctl run start
```

stop the server

```bash
choreoctl run stop
```