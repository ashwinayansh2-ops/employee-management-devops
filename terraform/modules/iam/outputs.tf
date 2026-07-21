output "private_instance_profile_name" {
  value = aws_iam_instance_profile.backend.name
}

output "backend_role_name" {
  value = aws_iam_role.backend_ssm.name
}