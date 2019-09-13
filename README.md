# Centralised AWS Backup Selection

[![Build Status](https://travis-ci.org/mergermarket/terraform-acuris-centralised-aws-backup-selection.svg?branch=master)](https://travis-ci.org/mergermarket/terraform-acuris-centralised-aws-backup-selection)

This module will deploy a selected backup plan to the project database

## Module Input Variables

- `identifier` - (string) - **REQUIRED** - The name shown in the resources of the backup plan.
- `database_arn` - (string) - **REQUIRED** - Reference to the database that will be attached to the plan.
- `plan_name` - (string) - **REQUIRED** - The name of an existing backup plan e.g. 'daily_plan'.
- `backup_role_name` - (string) - _optional_ -
  The name of the AWS role used for backups. This defaults to "backup_role" unless specified.

## Usage

```hcl
module "backup_selection" {
  source       = "github.com/mergermarket/terraform-acuris-centralised-aws-backup-selection"
  identifier   = "${aws_db_instance.example_database.identifier}"
  database_arn = "${aws_db_instance.example_database.arn}"
  plan_name    = "daily_plan"
}
```
