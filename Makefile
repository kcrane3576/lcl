# Scorer image (separate container that analyzes $(IMAGE))
SCORER_IMAGE ?= ghcr.io/chps-dev/chps-scorer:latest

# results directories
RESULTS_DIR ?= results
TEST_RESULTS_DIR := $(RESULTS_DIR)/tests
SCORE_RESULTS_DIR := $(RESULTS_DIR)/scores

# .PHONY: build rebuild run debug-build debug-run shell score
.PHONY: score-al2023 \
		build-al2023 rebuild-al2023 debug-build-al2023 run-al2023 shell-al2023 debug-run-al2023 \
        score-playwright \
		playwright-test-results \
		build-playwright rebuild-playwright debug-build-playwright \
        results-dirs

results-dirs:
	mkdir -p "$(TEST_RESULTS_DIR)" "$(SCORE_RESULTS_DIR)"

# al2023
AL2023_IMAGE_NAME ?= al2023-dev
AL2023_IMAGE_TAG ?= latest
AL2023_IMAGE := $(AL2023_IMAGE_NAME):$(AL2023_IMAGE_TAG)
AL2023_DOCKERFILE ?= Dockerfile.al2023
AL2023_TEST_RESULTS_DIR := $(TEST_RESULTS_DIR)/al2023/
AL2023_SCORE_RESULTS_DIR := $(SCORE_RESULTS_DIR)/al2023/

## Build the image (normal)
build-al2023:
	docker build \
		--build-arg BASE_IMAGE=$(AL2023_IMAGE) \
		-f $(AL2023_DOCKERFILE) \
		-t $(AL2023_IMAGE) .

## Rebuild the image from scratch with verbose output
debug-build-al2023 rebuild-al2023:
	docker build \
		--build-arg BASE_IMAGE=$(AL2023_IMAGE) \
		-f $(AL2023_DOCKERFILE) \
		--no-cache \
		--progress=plain \
		-t $(AL2023_IMAGE) .

## Run an interactive shell in the container with your current dir mounted
run-al2023 shell-al2023: build-al2023
	docker run --rm -it \
		-v "$$PWD":/workspace \
		-w /workspace \
		$(AL2023_IMAGE) \
		/bin/bash

## Run an interactive shell with bash tracing enabled
debug-run-al2023: build-al2023
	docker run --rm -it \
		-v "$$PWD":/workspace \
		-w /workspace \
		$(AL2023_IMAGE) \
		bash -lx

## Build the image and run a CHPs score against it
score-al2023: build-al2023
	@echo ">>> Running score for $(AL2023_IMAGE) using $(SCORER_IMAGE)"
	./scripts/run-score.sh \
	$(AL2023_IMAGE) \
	$(AL2023_DOCKERFILE) \
	$(AL2023_SCORE_RESULTS_DIR)

# playwright
PLAYWRIGHT_IMAGE_NAME ?= pw-min
PLAYWRIGHT_IMAGE_TAG ?= chrome-firefox
PLAYWRIGHT_IMAGE := $(PLAYWRIGHT_IMAGE_NAME):$(PLAYWRIGHT_IMAGE_TAG)
PLAYWRIGHT_DOCKERFILE ?= Dockerfile.playwright
PLAYWRIGHT_TEST_RESULTS_DIR := $(TEST_RESULTS_DIR)/playwright/
PLAYWRIGHT_SCORE_RESULTS_DIR := $(SCORE_RESULTS_DIR)/playwright/

## Build the Playwright image (normal)
build-playwright:
	docker build \
		--build-arg PLAYWRIGHT_TEST_RESULTS_DIR=/results/tests/playwright-test-results \
		--build-arg BASE_IMAGE=$(PLAYWRIGHT_IMAGE) \
		-f $(PLAYWRIGHT_DOCKERFILE) \
		-t $(PLAYWRIGHT_IMAGE) .

## Rebuild the Playwright image from scratch with verbose output
debug-build-playwright rebuild-playwright:
	docker build \
		--build-arg PLAYWRIGHT_TEST_RESULTS_DIR=/results/tests/playwright-test-results \
		--build-arg BASE_IMAGE=$(PLAYWRIGHT_IMAGE) \
		-f $(PLAYWRIGHT_DOCKERFILE) \
		--no-cache \
		--progress=plain \
		-t $(PLAYWRIGHT_IMAGE) .

## Build the Playwright image and run a CHPs score against it
score-playwright: build-playwright
	@echo ">>> Running score for $(PLAYWRIGHT_IMAGE) using $(SCORER_IMAGE)"
	./scripts/run-score.sh \
	$(PLAYWRIGHT_IMAGE) \
	$(PLAYWRIGHT_DOCKERFILE) \
	$(PLAYWRIGHT_SCORE_RESULTS_DIR)

## Build and run Playwright container (expects your pw-min Dockerfile setup)
playwright-test-results: results-dirs build-playwright
	docker run --rm \
		-v "$$PWD/$(RESULTS_DIR):/$(RESULTS_DIR)" \
		$(PLAYWRIGHT_IMAGE)

