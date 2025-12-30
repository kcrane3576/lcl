IMAGE_NAME ?= al2023-dev
TAG ?= latest
IMAGE := $(IMAGE_NAME):$(TAG)
DOCKERFILE ?= Dockerfile.lcl

.PHONY: build rebuild run debug-build debug-run shell

## Build the image (normal)
build:
	docker build -f $(DOCKERFILE) -t $(IMAGE) .

## Rebuild the image from scratch with verbose output
debug-build rebuild:
	docker build -f $(DOCKERFILE) --no-cache --progress=plain -t $(IMAGE) .

## Run an interactive shell in the container with your current dir mounted
run shell:
	docker run --rm -it \
		-v "$$PWD":/workspace \
		-w /workspace \
		$(IMAGE) \
		/bin/bash

## Run an interactive shell with bash tracing enabled
debug-run:
	docker run --rm -it \
		-v "$$PWD":/workspace \
		-w /workspace \
		$(IMAGE) \
		bash -lx
