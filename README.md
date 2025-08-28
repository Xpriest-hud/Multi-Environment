# Terraform Web Platform (AWS) – Multi-Environment with Auto-Scaling

This repo provisions a production-ready web app stack with separate **dev** and **prod** environments:

- **VPC** with public+private subnets across 2 AZs, **IGW**, single **NAT GW** (cost-aware)
- **ALB** in public subnets
- **Auto Scaling Group** of EC2 instances in private subnets (Nginx demo app)
- **RDS MySQL** (dev: single-AZ, prod: Multi-AZ)
- **CloudWatch Alarms** with optional **SNS** email alerts

## Structure

```
terraform-web-platform/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── outputs.tf
│   └── prod/
│       ├── main.tf
│       ├── terraform.tfvars
│       └── outputs.tf
└── modules/
    ├── networking/
    │   ├── main.tf
    │   └── variables.tf
    ├── compute/
    │   ├── main.tf
    │   └── variables.tf
    ├── database/
    │   ├── main.tf
    │   └── variables.tf
    └── monitoring/
        ├── main.tf
        └── variables.tf
```

## Prereqs

- Terraform >= 1.5
- AWS credentials loaded (e.g., `aws configure`)
- An email you can receive alerts on (optional)

## Usage

From each environment folder:

```bash
cd environments/dev  # or environments/prod
terraform init
terraform plan
terraform apply
```

Outputs include the **ALB DNS name** (hit it in a browser to see the demo app) and **RDS endpoint**.

> **Note:** The monitoring module needs the ALB `arn_suffix` and ASG name for CloudWatch dimensions. This repo derives them with data sources after creating the ALB/ASG. First apply may show computed values only after resources exist; re-running `apply` will fully wire alarms if needed.

## Cost Notes

- Dev uses a single-AZ RDS and smaller instance sizes.
- NAT Gateway incurs hourly + data processing charges. To reduce cost further for learning-only, consider removing NAT + using SSM Session Manager instead of SSH and Internet access.

## Customization

- Adjust CIDRs in `terraform.tfvars`.
- Change instance sizes, scaling limits, and CPU target in `modules/compute/variables.tf` or per-environment module blocks.
- Provide a real `alert_email` in tfvars to subscribe to SNS (confirm the subscription email).

## Clean Up

```bash
terraform destroy
```
