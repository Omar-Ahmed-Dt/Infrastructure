resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true #Required for EKS to run, default is true
  enable_dns_hostnames = true #Required for EKS to run, default is false
  tags = {
    Name = "terraform"
  }
}

resource "aws_subnet" "pub-subnets" {
  for_each                = var.subnets_cidr.pub_subs
  cidr_block              = each.value.IP
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = each.value.AZ

  tags = {
    Name                                = each.key
    "kubernetes.io/cluster/private_eks" = "shared"
    "kubernetes.io/role/elb"            = 1
  }
}

resource "aws_subnet" "priv-subnets" {
  for_each          = var.subnets_cidr.priv_subs
  cidr_block        = each.value.IP
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = each.value.AZ
  tags = {
    Name                                = each.key
    "kubernetes.io/cluster/private_eks" = "shared"
    "kubernetes.io/role/internal-elb"   = 1
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_eip" "my_eip" {
  depends_on = [aws_subnet.pub-subnets]
  count      = length(aws_subnet.pub-subnets)
}

resource "aws_nat_gateway" "ngw" {
  depends_on    = [aws_subnet.pub-subnets]
  count         = length(aws_subnet.pub-subnets)
  allocation_id = aws_eip.my_eip[count.index].id
  subnet_id     = values(aws_subnet.pub-subnets)[count.index].id
  tags = {
    Name = "NATGAteway-${count.index + 1}"
  }
}

resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "priv-route-table" {
  count  = length(aws_nat_gateway.ngw)
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[count.index].id
  }
}

resource "aws_route_table_association" "pub-rt-association" {
  count          = length(aws_subnet.pub-subnets)
  subnet_id      = values(aws_subnet.pub-subnets)[count.index].id
  route_table_id = aws_route_table.pub-route-table.id
}

resource "aws_route_table_association" "priv-rt-association" {
  count          = length(aws_subnet.priv-subnets)
  subnet_id      = values(aws_subnet.priv-subnets)[count.index].id
  route_table_id = aws_route_table.priv-route-table[count.index].id
}
