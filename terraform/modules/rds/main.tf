resource "aws_db_subnet_group" "subnet-group" {
  name        = "my-subnet-group"
  description = "My subnet group"
  subnet_ids  = var.priv_subnets
}

resource "aws_db_instance" "rds" {
  allocated_storage      = var.storage
  max_allocated_storage  = var.max_storage
  db_name                = var.db_name
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance
  username               = var.db_user
  password               = var.db_pass
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
  db_subnet_group_name   = aws_db_subnet_group.subnet-group.name
  skip_final_snapshot    = true
}
