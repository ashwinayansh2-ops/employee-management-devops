resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = var.security_group_ids
  subnets         = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_port
  protocol    = var.target_protocol
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_target_group_attachment" "this" {
  count = length(var.instance_id)

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance_id[count.index]
  port             = var.target_port
}


resource "aws_lb_listener" "frontend_alb_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}