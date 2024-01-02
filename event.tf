resource "aws_lambda_permission" "event" {
  count = var.event_pattern != null ? 1 : 0

  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this[0].arn
}

resource "aws_cloudwatch_event_rule" "this" {
  count = var.event_pattern != null ? 1 : 0

  name           = "${title(var.name)}-Event"
  description    = var.description
  event_pattern  = var.event_pattern
  event_bus_name = var.event_bus_name
}

resource "aws_cloudwatch_event_target" "this" {
  count = var.event_pattern != null ? 1 : 0

  rule           = aws_cloudwatch_event_rule.this[0].name
  target_id      = var.name
  arn            = aws_lambda_function.this.arn
  event_bus_name = var.event_bus_name
}
