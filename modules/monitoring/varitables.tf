variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "asg_name" {
  description = "Auto Scaling Group name to monitor"
  type        = string
}

variable "db_identifier" {
  description = "RDS DB identifier to monitor"
  type        = string
}

variable "alert_emails" {
  description = "List of emails to subscribe to SNS topic"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}
