variable "lambda1_root" {
  default = "./src/lambda1"
}
variable "lambda1_zip" {
  default = "./tmp/lambda1.zip"
}
variable "lambda1_name" {
  default = "lambda1"
}
locals {
  lambda1_name = "${var.prefix}${var.lambda1_name}-${random_id.id.hex}"
}

module "lambda1_zip" {
  source      = "./modules/python_lambda"
  python      = var.python
  lambda_root = abspath(var.lambda1_root)
  lambda_zip  = abspath(var.lambda1_zip)
}

module "lambda1" {
  source      = "./modules/lambda_base"
  lambda_name = local.lambda1_name
}

resource "aws_lambda_function" "lambda1" {
  filename      = module.lambda1_zip.zip.output_path
  function_name = local.lambda1_name
  role          = module.lambda1.role.arn
  handler       = "app.lambda_handler"
  # architectures    = ["x86_64"] # if region not support, comment this line
  publish          = true
  source_code_hash = module.lambda1_zip.zip.output_base64sha256
  runtime          = var.python
  depends_on       = [module.lambda1]
  tags = {
    project-name = "eagle"
  }
}


#--------
output "lambda1" {
  value = aws_lambda_function.lambda1.id
}
