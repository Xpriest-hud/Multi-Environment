output "sns_topic_arn" {
  description = "SNS Topic ARN for alerts"
  value       = aws_sns_topic.alerts.arn
}

output "asg_high_cpu_alarm_name" {
  description = "Name of the CloudWatch alarm for ASG high CPU"
  value       = aws_cloudwatch_metric_alarm.asg_high_cpu.alarm_name
}

output "rds_high_cpu_alarm_name" {
  description = "Name of the CloudWatch alarm for RDS high CPU"
  value       = aws_cloudwatch_metric_alarm.rds_high_cpu.alarm_name
}

output "rds_low_storage_alarm_name" {
  description = "Name of the CloudWatch alarm for RDS low storage"
  value       = aws_cloudwatch_metric_alarm.rds_low_storage.alarm_name
}
