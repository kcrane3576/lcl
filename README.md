# Use
```shell
make build
make debug-build
make run
make debug-run
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