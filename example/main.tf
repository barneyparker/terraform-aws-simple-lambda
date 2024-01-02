module "simple_function" {
  source = "../"

  name        = "simple-function"
  description = "A simple function"
  source_dir  = "${path.module}/src"
}


module "scheduled_function" {
  source = "../"

  name        = "scheduled-function"
  description = "A scheduled function"
  source_dir  = "${path.module}/src"

  schedule_expression = "cron(0 20 * * ? *)"
  schedule_payload = {
    "foo" = "bar"
  }
  schedule_timezone = "America/New_York"
}

module "event_function" {
  source = "../"

  name        = "event-function"
  description = "A event function"
  source_dir  = "${path.module}/src"

  event_pattern = jsonencode({
    "source" = ["aws.ec2"]
  })
}
