#
# Local vars
#
# These variables only exist within the context fo the terraform folder
#

locals {
  lambda_zip = "../../.aws-sam/build/lambda-1.0.0.zip"
}

#
# Provider
#
#   This block informs terraform what target cloud provider we're using.
# We could target google cloud platform or azure if desired.
#
#   The `default_tags` section attaches these tags to all resources deployed
# by this provider. This allows us to create many, many resources with
# tags that indicate associated service or environment.
#
provider "aws" {
  region                  = var.aws_region
  s3_force_path_style     = true
  shared_credentials_file = "~/.aws/credentials"
  profile                 = var.aws_profile

  default_tags {
    tags = {
      Environment = "example"
      Service     = "terraform-example"
    }
  }
}

#
# Lambda Function Definition
#
#   Anything starting with keyword `resource` is something
# that terraform manages (i.e. creates, modifies, destroys)
#
#   Note that resources can reference eachother in same folder.
# E.g. role = aws_iam_role.lambda_role.arn
#

resource "aws_lambda_function" "lambda" {
  function_name    = "terraform-lambda-example"
  filename         = local.lambda_zip
  source_code_hash = filebase64sha256(local.lambda_zip)
  role             = aws_iam_role.lambda_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
}

#
# Lambda Role
#

resource "aws_iam_role" "lambda_role" {
  name               = "terraform_lambda_example_role"
  assume_role_policy = file("${path.module}/policies/assume_role_policy.json")
}

#
# Policy Attachments
#

resource "aws_iam_role_policy_attachment" "execution_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" # already definied in AWS
}
