#!/usr/bin/env bash

# Input arguments
IMAGE=$1
DOCKERFILE="$PWD/$2"
REPORT_DIR="$3"

# chps-scorer image
SCORER_IMAGE="ghcr.io/chps-dev/chps-scorer:latest"

mkdir -p "$REPORT_DIR"

echo "============================================================"
echo "  CHPs Score Report"
echo "  Image:       $IMAGE"
echo "  Dockerfile:  $DOCKERFILE"
echo "  Report:  $REPORT_DIR"
echo "============================================================"
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
echo "------------------------------------------------------------"
echo "  Human-readable summary"
echo "------------------------------------------------------------"
cat "$REPORT_DIR/chps-score.txt"
echo "------------------------------------------------------------"
echo "Done!"
echo "============================================================"
