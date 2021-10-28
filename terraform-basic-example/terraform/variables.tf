#
#   This file contains variables that are needed for this terraform folder.
# Resources within the folder can reference these values with `var.<varname>`.
# For example `var.aws_region`
#
#   These can be auto populated with a `terraform.tfvars` file that auto sets the variables
# For example <terraform.tfvars>:
#
#   aws_region="eu-west-1"
#   aws_profile="joe"

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "aws_profile" {
  type = string
}
