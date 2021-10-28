data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = data.aws_region.current.name
}

#
# API GW
#

resource "aws_api_gateway_rest_api" "example_api" {
  name = "terraform-apigw-example-${var.env}"
}

#
# Create deployment state, "dev"
#

resource "aws_api_gateway_deployment" "example_api" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
}

resource "aws_api_gateway_stage" "dev" {
  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  deployment_id = aws_api_gateway_deployment.example_api.id
  stage_name    = "dev"
}


#
# Allow API Gateway to invoke lambda
#
resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = var.proxy_lambda_name
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${local.aws_region}:${local.aws_account_id}:${aws_api_gateway_rest_api.example_api.id}/*/*"
}
