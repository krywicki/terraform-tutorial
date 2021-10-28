variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "aws_profile" {
  type = string
}

variable "api_proxy_lambda_zip" {
  type        = string
  description = "File path to lambda zip file"
}

variable "env" {
  type        = string
  description = "Environment name (e.g. prod, test, etc.)"
}
