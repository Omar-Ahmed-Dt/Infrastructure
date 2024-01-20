data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami.filter]
  }
  owners = [var.ami.owner]
}

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.pub_subnets[0]
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  key_name               = var.key_name
  tags = {
    Name = "bastion_host"
  }
}
