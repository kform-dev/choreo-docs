# Prerequisites

## CPU architecture

All the choreo components run on both AMD and ARM based CPU

## Operating system

We tested on WSL for windows and Linux and darwin OS.

## choreoctl

Choreoctl is a command line tool for communicating with a Choreo server.

choreoctl is a single binary built for linux and Mac OS, distributed via [ghreleases][ghreleases]. It


/// tab | linux/Mac OS

To download & install the latest release the following automated [installation script][installscript] can be used.

```bash
bash -c "$(curl -sL https://github.com/kform-dev/choreo/raw/main/install-choreoctl.sh)"
```

As a result, the latest `choreoctl` version will be installed in the /usr/local/bin directory and the version information will be printed out.

To install a specific version of `choreoctl`, provide the version with -v flag to the installation script:

```bash
bash -c "$(curl -sL https://github.com/kform-dev/choreo/raw/main/install-choreoctl.sh)" -- -v 0.0.1
```

///

/// tab | Packages

Linux users running distributions with support for deb/rpm packages can install choreoctl using pre-built packages:

```bash
bash -c "$(curl -sL https://github.com/kform-dev/choreo/raw/main/install-choreoctl.sh)" -- --use-pkg
```

///


## choreoctl autocomplete


/// tab | bash

```bash
source <(choreoctl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(choreoctl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
```

///

/// tab | zsh

```zsh
source <(choreoctl completion zsh)  # set up autocomplete in zsh into the current shell
echo '[[ $commands[choreoctl] ]] && source <(choreoctl completion zsh)' >> ~/.zshrc # add autocomplete permanently to your zsh shell
```

///

[ghreleases]: https://github.com/kform-dev/choreo/releases
[installscript]: https://github.com/kform-dev/choreo/raw/main/install-choreoctl.sh