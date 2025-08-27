provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "rds_subnet" {
  name = "rds-subnet"
  subnet_ids = [ "subnet1", "subnet2" ]
  
}

resource "aws_security_group" "rds_sg" {
  name = "rds-sg"
  description = "security group for rds cluster"
  vpc_id = ["dev-vpc"]


  ingress {
    to_port = 3306
    from_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_rds_cluster" "rds-cluster-1" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_mode             = "provisioned"
  master_username         = "admin"
  master_password         = "passpassword"  # Store securely in production!
  backup_retention_period = 5
  preferred_backup_window = "02:00-02:00"
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true

  tags = {
    Name = "Aurora rds cluster"
  }
}
