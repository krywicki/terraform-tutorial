# basic-example

Covers basic terraform examples


## Overview

This terraform project deploys the following

* Lambda
    * Runtime: python3.8
    * Code: src/
    * Handler: main.lambda_handler


The lambda performs a simple echo back of given input.

## terraform folder

Any `.tf` files under this folder are terraform files. Whenever a `terraform <cmd>` call is made, the working directory has all
the `.tf` files evaluated and processed.

### `terraform/main.tf`

This is a typical file that is seen in terraform folder and is used to indicate where most of
the code goes, though it can be named anything.

### `terraform/variables.tf`

This file defines what variables are required for the terraform folder space. These variables can
be auto populated by either providing them at `terraform <cmd> -var my_var=1` call or by profiding
a `terraform.tfvars` file.

* Example `terraform.tfvars` file
    * ```terraform
        aws_profile="default"
        aws_region="us-east-1"
        ```

### `terraform/policies`

It's generally a good idea to place policies in a common area, especiialy if an admin needs to
approve the policies ahead of time.


## Core terraform commands

* `terraform init`
    * Initializes terraform folder
        * Pulls down resources & modules needed for deployment
    * Command creates the following
        * `.terraform`
        * `.terraform.lock.hcl`
    * Output:
        ```txt
        $ terraform init

        Initializing the backend...

        Initializing provider plugins...
        - Finding latest version of hashicorp/aws...
        - Installing hashicorp/aws v3.63.0...
        - Installed hashicorp/aws v3.63.0 (signed by HashiCorp)

        Terraform has created a lock file .terraform.lock.hcl to record the provider
        selections it made above. Include this file in your version control repository
        so that Terraform can guarantee to make the same selections by default when
        you run "terraform init" in the future.

        Terraform has been successfully initialized!

        You may now begin working with Terraform. Try running "terraform plan" to see
        any changes that are required for your infrastructure. All Terraform commands
        should now work.

        If you ever set or change modules or backend configuration for Terraform,
        rerun this command to reinitialize your working directory. If you forget, other
        commands will detect it and remind you to do so if necessary.
        ```

* `terraform validate`
    * Good for checking if you're missing  variables or messed up `.tf` formatting
    * Output
        ```txt
        Success! The configuration is valid.
        ```

* `terraform plan`
    * Good for seeing what changes will be performed when a `terraform apply` is done
    * Can save output and give to someone else for review
    * Output
        ```txt
        $ terraform plan

        Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
        + create

        Terraform will perform the following actions:

        # aws_iam_role.lambda_role will be created
        + resource "aws_iam_role" "lambda_role" {
            + arn                   = (known after apply)
            + assume_role_policy    = jsonencode(
                    {
                    + Statement = [
                        + {
                            + Action    = "sts:AssumeRole"
                            + Effect    = "Allow"
                            + Principal = {
                                + Service = "lambda.amazonaws.com"
                                }
                            + Sid       = "Terraform0"
                            },
                        ]
                    + Version   = "2012-10-17"
                    }
                )
            + create_date           = (known after apply)
            + force_detach_policies = false
            + id                    = (known after apply)
            + managed_policy_arns   = (known after apply)
            + max_session_duration  = 3600
            + name                  = "terraform_lambda_example_role"
            + name_prefix           = (known after apply)
            + path                  = "/"
            + tags_all              = {
                + "Environment" = "example"
                + "Service"     = "terraform-example"
                }
            + unique_id             = (known after apply)

            + inline_policy {
                + name   = (known after apply)
                + policy = (known after apply)
                }
            }

        # aws_iam_role_policy_attachment.execution_policy will be created
        + resource "aws_iam_role_policy_attachment" "execution_policy" {
            + id         = (known after apply)
            + policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
            + role       = "terraform_lambda_example_role"
            }

        # aws_lambda_function.lambda will be created
        + resource "aws_lambda_function" "lambda" {
            + architectures                  = (known after apply)
            + arn                            = (known after apply)
            + filename                       = "../../.aws-sam/build/lambda-1.0.0.zip"
            + function_name                  = "terraform-lambda-example"
            + handler                        = "main.lambda_handler"
            + id                             = (known after apply)
            + invoke_arn                     = (known after apply)
            + last_modified                  = (known after apply)
            + memory_size                    = 128
            + package_type                   = "Zip"
            + publish                        = false
            + qualified_arn                  = (known after apply)
            + reserved_concurrent_executions = -1
            + role                           = (known after apply)
            + runtime                        = "python3.8"
            + signing_job_arn                = (known after apply)
            + signing_profile_version_arn    = (known after apply)
            + source_code_hash               = "Diwscw9wOWEJl2P5qy/KMc28YF2YSZGr4c4xa6fxyhM="
            + source_code_size               = (known after apply)
            + tags_all                       = {
                + "Environment" = "example"
                + "Service"     = "terraform-example"
                }
            + timeout                        = 3
            + version                        = (known after apply)

            + tracing_config {
                + mode = (known after apply)
                }
            }

        Plan: 3 to add, 0 to change, 0 to destroy.
        ```

* `terraform apply`
    * Provides same output as `terraform plan`
    * Also prompts for `yes` input before deploying changes
    * Output
        ```txt
        $ terraform apply

        Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
        + create

        Terraform will perform the following actions:

        # aws_iam_role.lambda_role will be created
        + resource "aws_iam_role" "lambda_role" {
            + arn                   = (known after apply)
            + assume_role_policy    = jsonencode(
                    {
                    + Statement = [
                        + {
                            + Action    = "sts:AssumeRole"
                            + Effect    = "Allow"
                            + Principal = {
                                + Service = "lambda.amazonaws.com"
                                }
                            + Sid       = "Terraform0"
                            },
                        ]
                    + Version   = "2012-10-17"
                    }
                )
            + create_date           = (known after apply)
            + force_detach_policies = false
            + id                    = (known after apply)
            + managed_policy_arns   = (known after apply)
            + max_session_duration  = 3600
            + name                  = "terraform_lambda_example_role"
            + name_prefix           = (known after apply)
            + path                  = "/"
            + tags_all              = {
                + "Environment" = "example"
                + "Service"     = "terraform-example"
                }
            + unique_id             = (known after apply)

            + inline_policy {
                + name   = (known after apply)
                + policy = (known after apply)
                }
            }

        # aws_iam_role_policy_attachment.execution_policy will be created
        + resource "aws_iam_role_policy_attachment" "execution_policy" {
            + id         = (known after apply)
            + policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
            + role       = "terraform_lambda_example_role"
            }

        # aws_lambda_function.lambda will be created
        + resource "aws_lambda_function" "lambda" {
            + architectures                  = (known after apply)
            + arn                            = (known after apply)
            + filename                       = "../../.aws-sam/build/lambda-1.0.0.zip"
            + function_name                  = "terraform-lambda-example"
            + handler                        = "main.lambda_handler"
            + id                             = (known after apply)
            + invoke_arn                     = (known after apply)
            + last_modified                  = (known after apply)
            + memory_size                    = 128
            + package_type                   = "Zip"
            + publish                        = false
            + qualified_arn                  = (known after apply)
            + reserved_concurrent_executions = -1
            + role                           = (known after apply)
            + runtime                        = "python3.8"
            + signing_job_arn                = (known after apply)
            + signing_profile_version_arn    = (known after apply)
            + source_code_hash               = "Diwscw9wOWEJl2P5qy/KMc28YF2YSZGr4c4xa6fxyhM="
            + source_code_size               = (known after apply)
            + tags_all                       = {
                + "Environment" = "example"
                + "Service"     = "terraform-example"
                }
            + timeout                        = 3
            + version                        = (known after apply)

            + tracing_config {
                + mode = (known after apply)
                }
            }

        Plan: 3 to add, 0 to change, 0 to destroy.

        Do you want to perform these actions?
        Terraform will perform the actions described above.
        Only 'yes' will be accepted to approve.

        Enter a value: yes

        aws_iam_role.lambda_role: Creating...
        aws_iam_role.lambda_role: Creation complete after 1s [id=terraform_lambda_example_role]
        aws_iam_role_policy_attachment.execution_policy: Creating...
        aws_lambda_function.lambda: Creating...
        aws_iam_role_policy_attachment.execution_policy: Creation complete after 0s [id=terraform_lambda_example_role-20211028221258814300000001]
        aws_lambda_function.lambda: Still creating... [10s elapsed]
        aws_lambda_function.lambda: Creation complete after 17s [id=terraform-lambda-example]

        Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
        ```
