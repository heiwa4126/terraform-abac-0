# AWS Lambdaでだいたい使う標準的なリソース
#  - CloudWatch log
#  - lambda role
# を作成する

variable "lambda_name" {}
variable "retention_in_days" {
  default = 14
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "default" {
  path               = "/lambda/"
  name               = var.lambda_name
  assume_role_policy = data.aws_iam_policy_document.default.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${var.lambda_name}"
  retention_in_days = var.retention_in_days
}

output "role" {
  value = aws_iam_role.default
}
output "log" {
  value = aws_cloudwatch_log_group.default
}
