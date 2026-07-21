resource "aws_db_instance" "read_replica" {

  identifier = "springboot-db-replica"

  replicate_source_db = var.primary_db_identifier

  instance_class = "db.t3.micro"

  publicly_accessible = false

  auto_minor_version_upgrade = true

  skip_final_snapshot = true

  tags = {
    Name = "springboot-db-replica"
  }
}