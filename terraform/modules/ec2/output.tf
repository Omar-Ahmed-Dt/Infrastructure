output "bastion_host_id" {
  value = aws_instance.bastion_host.id
}

output "bastion_host_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "bastion_host_private_ip" {
  value = aws_instance.bastion_host.private_ip
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}
