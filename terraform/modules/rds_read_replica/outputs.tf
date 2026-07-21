output "db_arn" {
  value = aws_db_instance.read_replica.arn
}


output "replica_endpoint" {
  value = aws_db_instance.read_replica.endpoint
}

output "db_identifier" {
  value = aws_db_instance.read_replica.identifier
}