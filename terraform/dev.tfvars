vpc_cidr = "10.0.0.0/16"
region   = "us-east-1"
subnets = {
  pub_subs = {
    public-subnet-1 = {
      IP = "10.0.0.0/24",
      AZ = "us-east-1a"
    },
    public-subnet-2 = {
      IP = "10.0.2.0/24",
      AZ = "us-east-1b"
    }
  },
  priv_subs = {
    private-subnet-1 = {
      IP = "10.0.1.0/24",
      AZ = "us-east-1a"
    },
    private-subnet-2 = {
      IP = "10.0.3.0/24",
      AZ = "us-east-1b"
    }
  }
}
instance_type = "t2.micro"
ami = {
  owner  = "099720109477",
  filter = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

cluster_name = "private_eks"
