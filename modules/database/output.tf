output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "db_port" {
  description = "The port the RDS instance is listening on"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "The name of the initial database"
  value       = aws_db_instance.this.db_name
}

output "db_username" {
  description = "The master username for the RDS instance"
  value       = aws_db_instance.this.username
  sensitive   = true
}

output "db_subnet_group" {
  description = "The RDS subnet group name"
  value       = aws_db_subnet_group.this.name
}

output "db_identifier" {
  description = "The RDS DB instance identifier"
  value       = aws_db_instance.this.id
}

