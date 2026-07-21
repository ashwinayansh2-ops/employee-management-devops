output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "frontend_security_group_id" {
  value = aws_security_group.frontend.id

}

output "backend_security_group_id" {
  value = aws_security_group.backend.id
}


output "sonarqube_security_group_id" {
  value = aws_security_group.sonarqube.id

}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

