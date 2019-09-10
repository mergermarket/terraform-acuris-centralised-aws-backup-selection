variable "plan_name" {
  description = "The name of the backup plan e.g. 'daily_plan'."
}

variable "database" {
  description = "Data base to attach the plan."
}

variable "backup_role_name" {
  description = "The name of the IAM role for the backup service to use."
  default     = "backup_role"
}
