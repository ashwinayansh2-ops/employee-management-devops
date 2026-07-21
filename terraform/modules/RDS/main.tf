resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier = "springboot-db"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name = "springboot"

  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [var.rds_sg_id]

  publicly_accessible = false

  skip_final_snapshot = true

  multi_az = false

  backup_retention_period = 7
}
