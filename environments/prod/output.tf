output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnets_ids" {
  value = module.networking.public_subnets_ids
}

output "private_subnets_ids" {
  value = module.networking.private_subnets_ids
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = module.compute.alb_dns_name
}

output "alb_target_group_arn" {
  description = "Target group ARN for the ALB"
  value       = module.compute.alb_target_group_arn
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = module.compute.asg_name
}

output "compute_sg_id" {
  description = "Security Group ID from Compute module"
  value       = module.compute.security_group_id
}

# Database Outputs
output "database_endpoint" {
  description = "Database endpoint"
  value       = module.database.db_endpoint
}

output "database_port" {
  description = "Database port"
  value       = module.database.db_port
}

output "database_name" {
  description = "Database name"
  value       = module.database.db_name
}

output "database_username" {
  description = "Database master username"
  value       = module.database.db_username
  sensitive   = true
}

# Monitoring Outputs
output "monitoring_sns_topic_arn" {
  description = "SNS Topic ARN for monitoring alerts"
  value       = module.monitoring.sns_topic_arn
}

output "monitoring_asg_cpu_alarm_name" {
  description = "CloudWatch alarm name for ASG high CPU"
  value       = module.monitoring.asg_high_cpu_alarm_name
}

output "monitoring_rds_cpu_alarm_name" {
  description = "CloudWatch alarm name for RDS high CPU"
  value       = module.monitoring.rds_high_cpu_alarm_name
}

output "monitoring_rds_storage_alarm_name" {
  description = "CloudWatch alarm name for RDS low storage"
  value       = module.monitoring.rds_low_storage_alarm_name
}


