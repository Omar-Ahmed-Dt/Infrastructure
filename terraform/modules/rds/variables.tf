variable "storage" {
  type    = number
  default = 10
}

variable "max_storage" {
  type    = number
  default = 20
}

variable "db_name" {
  type    = string
  default = "mydb"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_engine_version" {
  type    = string
  default = "5.7"
}

variable "db_instance" {
  type    = string
  default = "db.t3.micro"
}

variable "db_user" {
  type    = string
  default = "admin"
}

variable "db_pass" {
  type    = string
  default = "password!123"
}

variable "priv_subnets" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}
