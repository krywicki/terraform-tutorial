
variable "env" {
  type        = string
  description = "Environment name (e.g. test, prod, etc.)"
}

variable "proxy_lambda_arn" {
  type        = string
  description = "Proxy Lambda ARN to which all API Gateway HTTP requests will be routed to"
}

variable "proxy_lambda_name" {
  type        = string
  description = "Name of proxy lambda"
}

variable "proxy_lambda_invoke_arn" {
  type        = string
  description = "Lambda invoke arn"
}
