#!/usr/bin/env bash
set -e

BUILD_HOME_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
IMAGE="srrs-ooph"
REGISTRY="${REGISTRY:-srrs-registry.notprod.homeoffice.gov.uk}"

mkdir -p ${PWD}/tmp

echo "Starting docker build with params:'$@'..."
if docker run -i --rm=true \
  -v ${PWD}:/code \
  -v ${PWD}/tmp/.ivy2:/root/.ivy2/ \
  -v ${PWD}/tmp/.sbt:/root/.sbt/ \
  -e BUILD_NUMBER=${BUILD_NUMBER} \
  -e "ARTIFACTORY_USERNAME=${ARTIFACTORY_USERNAME}" \
  -e "ARTIFACTORY_PASSWORD=${ARTIFACTORY_PASSWORD}" \
  quay.io/ukhomeofficedigital/scala-play:v0.1.4 \
  /code/build.sh $@ ; then


    ok=0
else
    ok=1
fi

if [ ${ok} -ne 0 ]; then
    echo "Failed build"
    exit 1
fi

exit 0
