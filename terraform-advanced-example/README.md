# basic-example

Covers advanced terraform examples

## Overview

This deploys an `API Gateway` that proxies requests over to an `AWS Lambda`.


The API endpoints are

* HTTP GET `/health-check`
    * A simple health check endpoint
    * Request
        ```bash
        curl -L '<url>' -H 'Content-Type: application/json'
        ```
    * Responds
        ```json
        {
            "status": "OK"
        }
        ```

* HTTP POST `/echo`
    * Echos back json input
    * Request
        ```bash
        curl -L -X POST '<url>' -H 'Content-Type: application/json' \
        --data-raw '{
            "hello": "world"
        }'
        ```
    * Response
        ```json
        {
            "hello": "world"
        }
        ```

## `terraform/`

* `envs-common/`
    * Has common terraform code that is used across multiple target AWS accounts, regions, &
        environments
    * The contents of this folder are sym-linkes (soft-linked) under the various terraform
        `envs` targets

* `envs/`
    * The various AWS accounts, regions, & environments to deploy to

* `env-init.py`
    * Simple python script to intialize terraform deployment folder with by symlinking
        `envs-common` contents to.

## `terraform/envs-common/`

* Contains folders and files that are sym-linked into multiple terraform deployment folders
    (i.e. `envs/**`)

* `modules/`
    * Provides easy way of grouping a bunch of terraform resources together into logical
        components (think services)
    * Can be imported by terraform deployment folder
    * Can be provided with input variables to configure resources

* `main.tf` & `variables.tf`
    * Refer back to [terraform-basic-example](../terraform-basic-example/README.md) for more detail.


## `terraform/envs/**/backend.tf`

* A typical file name for anything specifying a backend block
    * A place to store the `terraform state file`

Terraform state files are kept locally by default. Unfortunately this can cause `terraform apply`
conflicts if the terraform state file no longer matches existing cloud infrastructure.

This can occur if two devs are deploying changes in separate rep branches.

The solution is to keep the `terraform state` file in a common location, like S3.
