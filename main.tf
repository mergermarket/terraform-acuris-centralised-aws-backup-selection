data "aws_region" "current" {}
data "external" "plan_id" {
  program = [
    "python",
    "${path.module}/scripts/get_plan_id.py",
  ]

  query = {
    plan_name = "${var.plan_name}",
    region = "${data.aws_region.current.name}"
  }
}

data "aws_caller_identity" "current" {}

locals {
  plan       = "${data.external.plan_id.result}"
  account_id = "${data.aws_caller_identity.current.account_id}"
}

resource "aws_backup_selection" "central_backup_selection" {
  name         = "${var.identifier}"
  iam_role_arn = "arn:aws:iam::${local.account_id}:role/${var.backup_role_name}"
  plan_id      = "${lookup(local.plan,"plan_id")}"

  resources = [
    "${var.database_arn}",
  ]

  not_resources = [
    "arn:aws:dynamodb:*:*:table/*",
    "arn:aws:rds:*:*:cluster:*",
    "arn:*:fsx:*",
    "arn:aws:elasticfilesystem:*:*:file-system/*"
  ]
}
