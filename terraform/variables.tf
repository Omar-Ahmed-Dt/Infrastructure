variable "vpc_cidr" {
  type = string

}
variable "region" {
  type = string

}

variable "subnets" {
  type = map(any)
}

variable "instance_type" {
  type = string
}
variable "ami" {
  type = map(any)
}

variable "cluster_name" {
  type = string
}
