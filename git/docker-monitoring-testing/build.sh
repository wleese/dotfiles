#!/bin/bash
#

VERSION=0.1
IMAGE=itops/montest

sed "s/<<VERSION>>/${VERSION}/g" < Dockerfile.template > Dockerfile

if [ -z "$ONJENKINS" ]; then
  echo "Building docker image ${IMAGE}:${VERSION} locally"
  docker build -t "${IMAGE}:${VERSION}" .
fi

echo "${VERSION}" > version.txt
echo "Version in version.txt: $(cat version.txt)"
