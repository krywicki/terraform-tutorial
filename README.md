# terraform-tutorial
Basic Terraform Tutorial Project

## Requirements

* Linux/MacOS
* SAM Cli
* Makefile
* python3.8
* terraform
* Docker
* AWS Cli

## Overview

This example covers various `terraform` core features and some gotchas that a developer may run into when building infrastructure in AWS.

All of the examples make use of `AWS Lambda` code (written in python3.8) in the `src/` directory.

## Examples

* [terraform-basic-example](./terraform-basic-example/README.md)
    * Covers
        * Basic resource creation
        * Validation
        * Planning
        * Deployment


* [terraform-advanced-example](./terraform-advanced-example/README.md)
    * Covers
        * modules
        * backends
        * inputs/outputs
