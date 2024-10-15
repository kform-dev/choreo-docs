PORT ?= 8000

ifeq ($(shell command -v podman 2> /dev/null),)
    CMD=docker
else
    CMD=podman
endif

docker-run:
	$(CMD) build . -t mkdocs-kform-docs
	$(CMD) run --rm --name mkdocs-kform-docs -v "$$(pwd)":/docs -p ${PORT}:${PORT} --entrypoint ash mkdocs-kform-docs:latest -c 'mkdocs serve -a 0.0.0.0:${PORT}'
