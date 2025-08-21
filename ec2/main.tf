provider "aws" {
  region = "us-east-1"
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