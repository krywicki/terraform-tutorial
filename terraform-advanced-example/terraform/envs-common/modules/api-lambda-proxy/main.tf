#
# Lambda Function Definition
#

resource "aws_lambda_function" "lambda" {
  function_name    = "apigw-terraform-lambda-example-${var.env}"
  filename         = var.lambda_zip
  source_code_hash = filebase64sha256(var.lambda_zip)
  role             = aws_iam_role.lambda_role.arn
  handler          = "main.api_gw_lambda_handler"
  runtime          = "python3.8"
}

#
# Lambda Role
#

resource "aws_iam_role" "lambda_role" {
  assume_role_policy = file("${path.module}/policies/assume_role_policy.json")
}

#
# Policy Attachments
#

resource "aws_iam_role_policy_attachment" "execution_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" # already definied in AWS
}
