resource "aws_iam_role" "this" {
  name                 = var.name
  assume_role_policy   = data.aws_iam_policy_document.lambda_assume.json
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/GELBoundary"

  inline_policy {
    name   = "Permissions"
    policy = data.aws_iam_policy_document.this.json
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    actions = [
      "events:PutEvents"
    ]
    resources = ["arn:aws:events:*:*:*"]
  }

  override_policy_documents = var.policies
}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
