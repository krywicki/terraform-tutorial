terraform {
  backend "s3" {
    bucket               = "terraform-example"
    key                  = "terraform-example/test/us-east-1/advanced-example.json"
    workspace_key_prefix = "workspaces"
    dynamodb_table       = "TerraformTest"
    region               = "eu-west-1"
  }
}
