# AL2023 Commands
Build: `make build`
```shell
docker build -f Dockerfile -t al2023-dev .
```

Run (interactive shell): `make run` or `make shell`
```shell
docker run --rm -it \
  -v "$PWD":/workspace \
  -w /workspace \
  al2023-dev \
  /bin/bash
```

Verbose / Debug Build: `make debug-build` or `make rebuild`
```shell
docker build -f Dockerfile \
  --no-cache \
  --progress=plain \
  -t al2023-dev-debug \
  .
```

Verbose / Debug Run: `make debug-run`
```shell
docker run --rm -it \
  -v "$PWD":/workspace \
  -w /workspace \
  al2023-dev \
  bash -lx
```

CHPs Score `Dockerfile`: `make score` (requires `make build`)
```shell
scripts/run-score.sh al2023-dev
```

# Playwright Commands
Build: `make build pw`
```shell
docker build -f Dockerfile.playwright -t playwright-test .
```