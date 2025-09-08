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


resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = 2 
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t2.medium" 
  engine             = aws_rds_cluster.aurora_cluster.engine
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

}
resource "aws_rds_cluster_parameter_group" "aurora_pg" {
  name        = "aurora-pg"
  family      = "aurora-mysql8.0"
  description = "Aurora MySQL parameter group"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }
}

resource "aws_rds_cluster_parameter_group" "parameter_grp_1" {
  name        = "rds-pg"
  family      = "aurora5.6"
  description = "RDS test parameter group"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}