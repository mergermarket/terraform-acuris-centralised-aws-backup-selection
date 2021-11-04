#!/bin/sh

echo "TEST TEST"

terraform init

terraform validate -var plan_name=myplan -var database_arn=mydbarn -var identifier=mydb

python3 -m unittest discover scripts

flake8 scripts
