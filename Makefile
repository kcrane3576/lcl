IMAGE_NAME ?= al2023-dev
TAG ?= latest
IMAGE := $(IMAGE_NAME):$(TAG)
DOCKERFILE ?= Dockerfile.lcl

# Scorer image (separate container that analyzes $(IMAGE))
SCORER_IMAGE ?= ghcr.io/chps-dev/chps-scorer:latest

.PHONY: build rebuild run debug-build debug-run shell score

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

## Build the image and run a CHPs score against it
score: build
	@echo ">>> Running score for $(IMAGE) using $(SCORER_IMAGE)"
	./scripts/run-score.sh $(IMAGE)