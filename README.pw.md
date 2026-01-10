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
rm -rf test-results && rm package-lock.json && rm -rf node_modules mkdir -p test-results

npm install

docker run --rm \
  -v "$PWD/test-results:/work/test-results" \
  pw-min:chrome-firefox
```