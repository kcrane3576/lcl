# Playwright Test
```shell
docker build -t pw-min:chrome-firefox .
```

```
docker run --rm \
  -v "$PWD/test-results:/work/test-results" \
  pw-min:chrome-firefox
```

```
docker build -t pw-min:chrome-firefox .
rm -rf test-results && mkdir -p test-results

docker run --rm \
  -v "$PWD/test-results:/work/test-results" \
  pw-min:chrome-firefox
```