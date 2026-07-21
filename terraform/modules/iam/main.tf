resource "aws_iam_role" "backend_ssm" {
  name = "backend-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "backend-ssm-role"
  }
}

resource "aws_iam_policy" "backend_rds_readonly" {
  name        = "backend-rds-readonly"
  description = "Allow backend EC2 to describe RDS resources"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters",
          "rds:DescribeDBSubnetGroups",
          "rds:DescribeDBEngineVersions"
        ]

        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy" "dynatrace_secret" {
  name        = "dynatrace-secret-read"
  description = "Allow EC2 to read Dynatrace API token"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      # Existing permissions
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]

        Resource = [
          "arn:aws:secretsmanager:us-east-1:083011581551:secret:dynatrace/api-token*",
          "arn:aws:secretsmanager:us-east-1:083011581551:secret:dynatrace/oneagent*"
        ]
      },

      # Add this new statement
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:ListSecrets"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "backend_secrets_manager" {
  name = "backend-secrets-manager-policy"
  role = aws_iam_role.backend_ssm.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backend_ssm" {
  role       = aws_iam_role.backend_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "backend_rds_readonly" {
  role       = aws_iam_role.backend_ssm.name
  policy_arn = aws_iam_policy.backend_rds_readonly.arn
}

resource "aws_iam_role_policy_attachment" "dynatrace_secret" {
  role       = aws_iam_role.backend_ssm.name
  policy_arn = aws_iam_policy.dynatrace_secret.arn
}

resource "aws_iam_instance_profile" "backend" {
  name = "backend-instance-profile"
  role = aws_iam_role.backend_ssm.name
}

