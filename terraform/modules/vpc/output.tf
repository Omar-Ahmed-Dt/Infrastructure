output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "pub_subnets" {
  value = values(aws_subnet.pub-subnets)[*].id
}

output "priv_subnets" {
  value = values(aws_subnet.priv-subnets)[*].id
}
