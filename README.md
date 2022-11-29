# Centralised AWS Backup Selection

[![Test](https://github.com/mergermarket/terraform-acuris-centralised-aws-backup-selection/actions/workflows/test.yml/badge.svg)](https://github.com/mergermarket/terraform-acuris-centralised-aws-backup-selection/actions/workflows/test.yml)

`Notice:`  
This module is being phased out in favour of resource tagging and auto enrolment for prod resources.  
The following resources **will not** work with this module as they are already covered by the aformentioned methods:  
Dynamodb  
Aurora  
Documentdb  
FSx  
EFS  
RDS  
see [centralised_aws_backup_service](https://github.com/mergermarket/centralised_aws_backup_service) for more details

---

This module will deploy a selected backup plan to the project database

## Module Input Variables

- `identifier` - (string) - **REQUIRED** - The name shown in the resources of the backup plan.
- `database_arn` - (string) - **REQUIRED** - Reference to the database that will be attached to the plan.
- `plan_name` - (string) - **REQUIRED** - The name of an existing backup plan e.g. 'daily_plan'.
- `backup_role_name` - (string) - _optional_ -
  The name of the AWS role used for backups. This defaults to "backup_role" unless specified.

## Usage

```hcl
module "backup-selection" {
  source       = "mergermarket/centralised-aws-backup-selection/acuris"
  version      = "1.0.2"
  identifier   = "${aws_db_instance.example_database.identifier}"
  database_arn = "${aws_db_instance.example_database.arn}"
  plan_name    = "default"
}
```
