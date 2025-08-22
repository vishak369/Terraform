provider "aws" {
  region = "us-east-1"
}


resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "ssh access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = ["amzn2-ami-hvm*"]
    }
  
}

resource "aws_instance" "bastion-host" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.medium"
  tags = {
    name =  "bastion host for platform"
  }
  
}