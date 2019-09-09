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

docker container run \
    --name "${IMAGE_ID}" \
    --entrypoint= \
    -d \
    "${IMAGE_ID}" \
    tail -f /dev/null

run_in_container terraform init
run_in_container terraform validate -var plan_name=myplan -var database=mydb
run_in_container python3 -m unittest discover scripts
run_in_container flake8 scripts
