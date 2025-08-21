output "instance_id" {
    value = aws_instance.bastion-host.id
}

output "public_ip address" {
  value = aws_instance.bastion-host.public_ip
}