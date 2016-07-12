#!/usr/bin/env bash

# Fail early!
set -e

MAJOR_VERSION="0.1"
PLAY_CMD=activator
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ "${1}" == "debug" ]; then
  bash -i
  exit 1
fi



if [ "${1}" == "publish" ] || [ "${2}" == "publish" ]; then
    export PUBLISH_CMD=publish
else
    export PUBLISH_CMD=publishLocal
fi


echo "[build.sh] using command: ${PLAY_CMD}"

echo "[build.sh] building..."
if ! ${PLAY_CMD} clean test ${PUBLISH_CMD} ; then
  echo "[build.sh] failure - $?"
  exit 1
else
  echo "[build.sh] Build success."
fi
