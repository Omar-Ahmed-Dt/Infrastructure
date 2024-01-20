variable "vpc_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type = map(any)
  default = {
    owner  = "099720109477",
    filter = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  }
}

variable "key_name" {
  type    = string
  default = "aws"
}

variable "pub_subnets" {
  type = list(any)
}

variable "priv_subnets" {
  type = list(any)
}
