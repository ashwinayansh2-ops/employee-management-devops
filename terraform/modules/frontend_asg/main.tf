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
  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Update system
    dnf update -y

    # Install NGINX
    dnf install -y nginx wget openssl


    # Configure NGINX

     TOKEN=$(aws secretsmanager get-secret-value \
    --secret-id dynatrace/api-token \
    --query SecretString \
    --output text)

    echo "Hi Shashi, from token: $TOKEN" > /usr/share/nginx/html/index.html
    systemctl enable nginx
    systemctl restart nginx

   

    # Download OneAgent
    wget -O Dynatrace-OneAgent.sh "https://aav98370.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?arch=x86" --header="Authorization: Api-Token $TOKEN"

    # Download Dynatrace Root Certificate
    wget https://ca.dynatrace.com/dt-root.cert.pem

    # Verify installer signature
    (
    echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'
    echo
    echo
    echo '----SIGNED-INSTALLER'
    cat Dynatrace-OneAgent.sh
    ) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

    # Install OneAgent
    /bin/sh Dynatrace-OneAgent.sh \
    --set-app-log-content-access=true \
    --set-infra-only=false

    EOF
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