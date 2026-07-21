#create security group for alb
resource "aws_security_group" "alb" {
  name        = "${var.env}-alb"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#create security group for frontend instances
resource "aws_security_group" "frontend" {
  name        = "${var.env}-frontend"
  description = "Security group for frontend instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "HTTPS from ALB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#create security group for backend instances
resource "aws_security_group" "backend" {
  name        = "${var.env}-backend"
  description = "Security group for backend instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from frontend"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#crearing sercurity for sonarQube
resource "aws_security_group" "sonarqube" {
  name        = "${var.env}-sonarqube"
  description = "Security group for SonarQube instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from frontend"
    from_port       = 9000
    to_port         = 9000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_mysql" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.backend.id

  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"

  description = "Allow MySQL from Backend SG"
}