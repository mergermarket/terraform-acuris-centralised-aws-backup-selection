data "external" "plan_id" {
  program = [
    "python",
    "${path.module}/scripts/get_plan_id.py",
  ]

  query = {
    plan_name = "${var.plan_name}"
  }
}

locals {
  plan = "${data.external.plan_id.result}"
}

resource "aws_backup_selection" "central_backup_selection" {
  name         = "central_backup_selection"
  plan_id      = "${lookup(local.plan,"plan_id")}"

  resources = [
    "${var.database}"
  ]
}
