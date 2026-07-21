resource "aws_instance" "frontend" {
  count         = length(var.subnet_ids)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  vpc_security_group_ids = [
    var.frontend_sg_id
  ]

  iam_instance_profile        = var.instance_profile
  associate_public_ip_address = false
  tags = {
    Name = "front-server-${count.index + 1}"
  }
  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install nginx -y
    systemctl start nginx
    systemctl enable nginx
  EOF
}