resource "aws_iam_role" "eks_admin_role" {
  #arn:aws:iam::611469625560:role/eks-admin-role
  name = "eks-admin-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::611469625560:root"
        }
      },
    ]
  })
  inline_policy {
    name = "eks-full-access-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "iam:ListRoles",
            "eks:*",
            "ssm:GetParameter"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }    
tags = {
    Name = "eks-admin-role"
  }
  max_session_duration = 10800
}
