variable "priv_subnets" {
  type = list(any)
}

variable "bastion_host_private_ip" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "ubuntu_ami_id" {
  type = string
}
