#!/bin/bash

# build container once to enable caching
(cd src-cloud-run-microservice && 
    ./build.sh &&
    ./push.sh)

# init and apply terraform
(cd terraform && 
    terraform init && 
    terraform plan --out terraform-plans/8.plan &&
    terraform apply "terraform-plans/8.plan")