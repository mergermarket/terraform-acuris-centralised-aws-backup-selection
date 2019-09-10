data "external" "plan_id" {
  program = [
    "python",
    "${path.module}/scripts/get_plan_id.py",
  ]

  query = {
    plan_name = "${var.plan_name}"
  }
}

data "aws_caller_identity" "current" {}

locals {
  plan       = "${data.external.plan_id.result}"
  account_id = "${data.aws_caller_identity.current.account_id}"
}

resource "aws_backup_selection" "central_backup_selection" {
  name         = "central_backup_selection"
  iam_role_arn = "arn:aws:iam::${local.account_id}:role/${var.backup_role_name}"
  plan_id      = "${lookup(local.plan,"plan_id")}"

  resources = [
    "${var.database}",
  ]
}
