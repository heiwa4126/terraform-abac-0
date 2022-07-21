variable "lambda_root" {
  # default = "/foo/contents/lambda1"
}
variable "lambda_zip" {
  # default = "/foo/tmp/lambda1.zip"
}
variable "python" {
  # default = "python3.9"
}

resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "${var.python} -m pip install -U -r ${var.lambda_root}/requirements.txt -t ${var.lambda_root}/"
  }
  triggers = {
    dependencies_versions = filemd5("${var.lambda_root}/requirements.txt")
    source_versions       = filemd5("${var.lambda_root}/app.py")
  }
}

data "archive_file" "default" {
  depends_on = [null_resource.default]
  excludes = [
    "__pycache__",
    "venv",
  ]
  type = "zip"
  # source_dir  = "${path.module}/${var.lambda_root}"
  # output_path = "${path.module}/${var.lambda_zip}"
  source_dir  = var.lambda_root
  output_path = var.lambda_zip
}

output "zip" {
  value = data.archive_file.default
}
