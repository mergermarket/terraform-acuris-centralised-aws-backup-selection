data "external" "plan_id" {
  program = [
    "python",
    "${path.module}/scripts/get_plan_id.py",
  ]

  query = {
    plan_name = "${variables.plan_name}"
  }
}

locals {
  plan_id     = "${data.external.plan_id.result}"
}

resource "aws_backup_selection" "central_backup_selection" {
  iam_role_arn = "${aws_iam_role.example.arn}"
  name         = "central_backup_selection"
  plan_id      = "${plan_id}"

  resources = [
    "${aws_db_instance.example.arn}",
    "${aws_ebs_volume.example.arn}",
    "${aws_efs_file_system.example.arn}",
  ]
}
