variable "plan_name" {
  description = "The name of the backup plan e.g. 'daily_plan'."
}

variable "database_arn" {
  description = "Reference to the database that will be attached to the plan."
}

variable "backup_role_name" {
  description = "The name of the IAM role for the backup service to use."
  default     = "backup_role"
}

variable "name" {
  description = "The name shown in the resources of the backup plan."
}
