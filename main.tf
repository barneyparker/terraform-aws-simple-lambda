data "archive_file" "this" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.root}/.terraform/${var.name}.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = var.name
  description      = var.description
  role             = aws_iam_role.this.arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256
  memory_size      = var.memory_size
  timeout          = var.timeout
  architectures    = [var.architecture]

  environment {
    variables = var.env_vars
  }

  logging_config {
    log_group             = var.log_group != null ? var.log_group : null
    log_format            = var.log_json ? "JSON" : "Text"
    application_log_level = var.log_json ? var.app_log_level : null
    system_log_level      = var.log_json ? var.sys_log_level : null
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_json ? var.log_group : "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.log_retention
}
