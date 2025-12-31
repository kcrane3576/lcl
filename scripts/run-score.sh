#!/usr/bin/env bash

IMAGE=$1
DOCKERFILE="$PWD/Dockerfile.lcl"
REPORT_DIR="$PWD/score-report"
SCORER_IMAGE="ghcr.io/chps-dev/chps-scorer:latest"

mkdir -p "$REPORT_DIR"

echo "Scoring image: $IMAGE"
echo "Using Dockerfile: $DOCKERFILE"
echo "Writing reports to: $REPORT_DIR"
echo

# Text report
echo "Generating text report..."
docker run --rm --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD":"$PWD" \
  -w "$PWD" \
  "$SCORER_IMAGE" \
  --local "$IMAGE" \
  -d "$DOCKERFILE" \
  > "$REPORT_DIR/chps-score.txt"

echo
echo "Done!"
echo "Text report: $REPORT_DIR/chps-score.txt"
