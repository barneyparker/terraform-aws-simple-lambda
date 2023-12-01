# Terraform AWS Simple Lambda

This is a simple Terraform module that creates a Lambda Function, IAM Role and Log Group for it.

Additional IAM policies can be passed in as a list of strings.

## Usage

```hcl
module "lambda" {
  source = "barneyparker/simple_lambda/aws"

  name         = "my-lambda"
  description  = "My Lambda Function"
  handler      = "index.handler"
  runtime      = "nodejs18.x"
  source_dir   = "${path.module}/function/my-lambda"
  architecture = "arm64

  env_vars = {
    MY_ENV_VAR = "my-value"
  }

  policies = [
    data.aws_iam_policy_document.example.json
  ]
}

data "aws_iam_policy_document" "example" {
  statement {
    actions = ["s3:*"]

    resources = ["*"]
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the Lambda Function. | `string` | n/a | yes |
| description | The description of the Lambda Function. | `string` | `""` | no |
| handler | The handler of the Lambda Function. | `string` | n/a | yes |
| runtime | The runtime of the Lambda Function. | `string` | n/a | yes |
| source\_dir | The path to the Lambda Function source code. | `string` | n/a | yes |
| log\_retention | The number of days to retain logs for. | `number` | `7` | no |
| memory\_size | The memory size of the Lambda Function. | `number` | `128` | no |
| timeout | The timeout of the Lambda Function. | `number` | `3` | no |
| architecture | The architecture of the Lambda Function. | `string` | `"x86_64"` | no |
| env\_vars | A map of environment variables to pass to the Lambda Function. | `map(string)` | `{}` | no |
| policies | A list of IAM policies to attach to the Lambda Function. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | The Name of the Lambda Function. |
| arn | The ARN of the Lambda Function. |
| invoke_arn | The Invoke ARN of the Lambda Function. |