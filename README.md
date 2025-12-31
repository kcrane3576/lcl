# Do
```shell
chmod +x scripts/run-score.sh
```

# Use
```shell
make build
make debug-build
make run
make debug-run
# Get chps-score for Dockerfile.lcl
make score
```

Build: `make build`
```shell
docker build -f Dockerfile.lcl -t al2023-dev .
```

Run (interactive shell): `make run | make shell`
```shell
docker run --rm -it \
  -v "$PWD":/workspace \
  -w /workspace \
  al2023-dev \
  /bin/bash
```

Verbose / Debug Build: `make debug-build | make rebuild`
```shell
docker build -f Dockerfile.lcl \
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

CHPs Score Dockerfile.lcl: `make score ` (requires `make build`)
```shell
scripts/run-score.sh al2023-dev
```
