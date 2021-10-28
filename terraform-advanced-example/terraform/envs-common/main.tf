#
# Provider
#
provider "aws" {
  region                  = var.aws_region
  s3_force_path_style     = true
  shared_credentials_file = "~/.aws/credentials"
  profile                 = var.aws_profile
}

module "api_lambda_proxy" {
  source     = "./modules/api-lambda-proxy"
  lambda_zip = var.api_proxy_lambda_zip
  env        = var.env
}

module "api_gw" {
  source                  = "./modules/api-gateway"
  proxy_lambda_arn        = module.api_lambda_proxy.lambda_arn
  proxy_lambda_name       = module.api_lambda_proxy.lambda_name
  proxy_lambda_invoke_arn = module.api_lambda_proxy.lambda_invoke_arn
  env                     = var.env
}
