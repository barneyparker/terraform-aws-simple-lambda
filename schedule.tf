resource "aws_lambda_permission" "schedule" {
  count = var.schedule_expression != null ? 1 : 0

  statement_id  = "AllowExecutionFromCloudWatchSchedule"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_scheduler_schedule.this[0].arn
}

resource "aws_scheduler_schedule" "this" {
  count = var.schedule_expression != null ? 1 : 0

  name                         = "${title(var.name)}-Schedule"
  state                        = "ENABLED"
  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = var.schedule_timezone
  start_date                   = var.schedule_start_date
  end_date                     = var.schedule_end_date

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = aws_lambda_function.this.arn
    role_arn = aws_iam_role.schedule[0].arn
    input    = jsonencode(var.schedule_payload)
  }
}

resource "aws_iam_role" "schedule" {
  count = var.schedule_expression != null ? 1 : 0

  name                 = "${var.name}-Schedule"
  assume_role_policy   = data.aws_iam_policy_document.schedule_assume[0].json
  permissions_boundary = var.boundary_policy_arn
  inline_policy {
    name   = "Permission"
    policy = data.aws_iam_policy_document.schedule[0].json
  }
}

data "aws_iam_policy_document" "schedule_assume" {
  count = var.schedule_expression != null ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "schedule" {
  count = var.schedule_expression != null ? 1 : 0

  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = [aws_lambda_function.this.arn]
  }
}
