#
# Local vars
#

locals {
  lambda_zip = "../../.aws-sam/build/lambda-1.0.0.zip"
}

#
# Provider
#
provider "aws" {
  region                  = var.aws_region
  s3_force_path_style     = true
  shared_credentials_file = "~/.aws/credentials"
  profile                 = var.aws_profile
}

#
# Lambda Function Definition
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
