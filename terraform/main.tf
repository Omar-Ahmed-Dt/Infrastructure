provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnets_cidr = var.subnets
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  priv_subnets  = module.vpc.priv_subnets
  pub_subnets   = module.vpc.pub_subnets
  instance_type = var.instance_type
  ami           = var.ami
}

module "rds" {
  source       = "./modules/rds"
  priv_subnets = module.vpc.priv_subnets
  vpc_id       = module.vpc.vpc_id
}


module "eks" {
  source                  = "./modules/eks"
  cluster_name            = var.cluster_name
  priv_subnets            = module.vpc.priv_subnets
  bastion_host_private_ip = module.ec2.bastion_host_private_ip
  vpc_id                  = module.vpc.vpc_id
  ubuntu_ami_id           = module.ec2.ubuntu_ami_id
}


resource "local_file" "output_file" {
  content  = <<-EOF
    cluster_name=${module.eks.cluster_name}
    cluster_endpoint=${module.eks.endpoint}
    cluster_ca=${module.eks.kubeconfig-certificate-authority-data}
    bastion_host_ip=${module.ec2.bastion_host_ip}
    EOF
  filename = "../outputs.txt"
}
