terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

variable region{}

provider "aws" {
  region = var.region
}


module "networking" {
  source               = "../../modules/networking"
  cidr_block           = "10.1.0.0/16"
  public_subnets_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets_cidrs = ["10.1.11.0/24", "10.1.12.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  tags = {
    Environment = var.environment
    Project     = "terraform-app"
  }
}

module "compute" {
  source             = "../../modules/compute"
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnets_ids
  private_subnet_ids = module.networking.private_subnets_ids
  name_prefix        = "${var.project}-${var.environment}"
  instance_type      = "t2.micro"
  min_size           = 1
  max_size           = 2
  desired_capacity   = 1

  tags = {
    Environment = var.environment
    Project     = "terraform-app"
  }
}

module "database" {
  source = "../../modules/database"
  project            = var.project
  tags               = var.tags
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnets_ids
  compute_sg_id      = module.compute.security_group_id
  environment        = var.environment 

  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
}

module "monitoring" {
  source       = "../../modules/monitoring"
  project      = var.project
  tags         = var.tags
  environment        = var.environment 

  asg_name      = module.compute.asg_name
  db_identifier = module.database.db_identifier  # Adjust if module.database exposes identifier separately

  alert_emails = ["Your Email address"]
}
