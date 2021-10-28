terraform {
  backend "s3" {
    bucket = "cxi-emea-terraform"
    key    = "terraform-examples/test/eu-west-1/advanced-example.json"
    region = "eu-west-1"
  }
}
