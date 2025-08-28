##############################
# DB Subnet Group
##############################
resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(
    {
      Name = "${var.project}-${var.environment}-db-subnet-group"
    },
    var.tags
  )
}

##############################
# DB Security Group
##############################
resource "aws_security_group" "db_sg" {
  name        = "${var.project}-${var.environment}-db-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow MySQL/Aurora access from compute SG"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [var.compute_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.project}-${var.environment}-db-sg"
    },
    var.tags
  )
}

##############################
# RDS Instance
##############################
resource "aws_db_instance" "this" {
  identifier              = "${var.project}-${var.environment}-db"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"        # Free tier eligible MySQL
  instance_class          = "db.t3.micro" # Free tier eligible
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = "default.mysql8.0"
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  skip_final_snapshot     = true

  tags = merge(
    {
      Name = "${var.project}-${var.environment}-db"
    },
    var.tags
  )
}

