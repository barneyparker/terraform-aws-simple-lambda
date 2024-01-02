module "simple_function" {
  source = "../"

  name        = "simple-function"
  description = "A simple function"
  source_dir  = "${path.module}/src"
}


module "scheduled_function" {
  source = "../"

  name        = "scheduled-function"
  description = "A simple function"
  source_dir  = "${path.module}/src"

  schedule_expression = "cron(0 20 * * ? *)"
  schedule_payload = {
    "foo" = "bar"
  }
  schedule_timezone = "America/New_York"
}
