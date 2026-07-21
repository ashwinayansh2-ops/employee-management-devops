output "public_subnet_ids" {
  value       = aws_subnet.public.*.id
  description = "The IDs of the public subnets"

}