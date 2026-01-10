# Requirements
- Docker
- Make
```shell
chmod +x scripts/run-score.sh
```

# Quickstart
```shell
# Playwright
make playwright-test-results
make score-playwright

# AL2023
make score-al2023
```

# Artifacts
- Playwright artifacts: `results/tests/*`
- Score artifacts: `results/scores/*`