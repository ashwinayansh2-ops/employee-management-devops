output "aws_instance" {
  value = aws_instance.frontend.*.id
  
}