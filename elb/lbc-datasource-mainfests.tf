data "http" "lbc_iam_policy" {
    url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
}
#lbc iam policy and role
resource "aws_iam_policy" "lbc_policy" {
name = "lbc-policy"
path = "/" #what is this do?
policy = data.http.lbc_iam_policy.body
}
#this is important
resource "aws_iam_role" "lbc_role" {
    name = "lbc-Role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:aud": "sts.amazonaws.com",            
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }        
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "role_policy_lbc" {
  policy_arn = aws_iam_policy.lbc_policy.arn
  role = aws_iam_role.lbc_role.name
  
}