#!/bin/bash

set -euo pipefail

IMAGE_ID="$(basename $(pwd))"

function cleanup() {
    docker container rm --force "${IMAGE_ID}"
}

function run_in_container() {
    docker container exec -i \
        "$(tty -s && echo -t)" \
        "${IMAGE_ID}" \
        "${@}"
}

trap cleanup EXIT

docker image build -t "${IMAGE_ID}" .

echo "Image Built"

docker container run \
    --name "${IMAGE_ID}" \
    -i \
    -w "/opt" \
    "${IMAGE_ID}"
