#create launch template
resource "aws_launch_template" "launch_template" {
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [
    var.frontend_sg_id
  ]

  iam_instance_profile {
    name = var.instance_profile
  }
 user_data = base64encode(
  file("${path.module}/../../scripts/frontend-userdata.sh")
)
}


resource "aws_autoscaling_group" "frontend" {

  name = "frontend-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = [
    var.private_subnet1,
    var.private_subnet2
  ]

  launch_template {

    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  target_group_arns = [
  var.target_group_arn
]

  health_check_type = "ELB"

  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "FrontendServer_Dynatrace_TOKEN_1"
    propagate_at_launch = true
  }


instance_refresh {
  strategy = "Rolling"

 # triggers = ["launch_template"]

  preferences {
    min_healthy_percentage = 100
  }
}

}