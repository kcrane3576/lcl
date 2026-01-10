# Requirements
- Docker
- Make
```shell
chmod +x scripts/run-score.sh
```

# Quickstart
```shell
# Playwright
make build-playwright
make playwright-test-results

# AL2023
make build
make score-al2023
make score-playwright

# All
make score-all
```

# Artifacts
- Playwright artifacts: `results/tests/`
- Score artifacts: `results/scores/`