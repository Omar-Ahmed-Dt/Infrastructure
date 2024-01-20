variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "main_vpc" {
  type    = string
  default = "terraform"

}

variable "subnets_cidr" {
  type = map(any)
  default = {
    pub_subs = {
      # key:
      public-subnet-1 = {
        # values: 
        IP = "10.0.0.0/24"
        AZ = "us-east-1a"

      }
      # key:
      public-subnet-2 = {
        # values: 
        IP = "10.0.1.0/24"
        AZ = "us-east-1b"

      }

    }
    priv_subs = {
      private-subnet-1 = {
        IP = "10.0.2.0/24"
        AZ = "us-east-1a"

      }
      private-subnet-2 = {
        IP = "10.0.3.0/24"
        AZ = "us-east-1b"

      }

    }
  }

}
