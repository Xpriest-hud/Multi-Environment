#########################
# Outputs
#########################
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnets_ids" {
  description = "IDs of the public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnets_ids" {
  description = "IDs of the private subnets"
  value       = [for s in aws_subnet.private : s.id]
}
