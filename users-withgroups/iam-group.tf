resource "aws_iam_group" "eksadmin_iam_group" {
    name = "eksadmins"
    path = "/"
}
resource "aws_iam_group_policy" "eks_admin_policy" {
    name = "eks_admins_group_policy"
    group = aws_iam_group.eksadmin_iam_group.name
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid    = "AllowAssumeOrganizationAccountRole"
        Resource = aws_iam_role.eks_admin_role.arn
      },
    ]
  }
    )
  
}
resource "aws_iam_user" "eks_user" {
    name =  "eks_user1"
    path =  "/"
    force_destroy = true
  
}
resource "aws_iam_group_membership" "grp-usr" {
    users = [ aws_iam_user.eks_user.name, ]
    name = "eksgroup"
    group = aws_iam_group.eksadmin_iam_group.name
}
resource "aws_iam_access_key" "example" {
  user = aws_iam_user.eks_user.name

  lifecycle {
    create_before_destroy = true # Ensure that the new access key is created before the old one is destroyed
  }
}

output "access_key_id" {
  value = aws_iam_access_key.example.id
  sensitive = true
}

output "secret_access_key" {
  value = aws_iam_access_key.example.secret
  sensitive = true
}