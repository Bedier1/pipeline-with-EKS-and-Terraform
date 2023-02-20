# Resource: IAM Policy for Cluster Autoscaler
resource "aws_iam_policy" "cluster_autoscaler_iam_policy" {
  name        = "AmazonEKSClusterAutoscalerPolicy"
  path        = "/"
  description = "EKS Cluster Autoscaler Policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:DescribeInstanceTypes"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}
# Resource: IAM Role for Cluster Autoscaler
## Create IAM Role and associate it with Cluster Autoscaler IAM Policy
resource "aws_iam_role" "cluster_autoscaler_iam_role" {
  name = "cluster-autoscaler"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
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
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
          }
        }        
      },
    ]
  })

  tags = {
    tag-key = "cluster-autoscaler"
  }
}
# Associate IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "cluster_autoscaler_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.cluster_autoscaler_iam_policy.arn 
  role       = aws_iam_role.cluster_autoscaler_iam_role.name
}
output "cluster_autoscaler_iam_role_arn" {
  description = "Cluster Autoscaler IAM Role ARN"
  value = aws_iam_role.cluster_autoscaler_iam_role.arn
}
# Datasource: EKS Cluster Auth 
data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}


# Install Cluster Autoscaler using HELM

# Resource: Helm Release 
resource "helm_release" "cluster_autoscaler_release" {
  depends_on = [aws_iam_role.cluster_autoscaler_iam_role ]            
  name       = "cluster-autoscaler"

  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  namespace = "kube-system"   

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = data.terraform_remote_state.eks.outputs.cluster_id
  }
  set {
    name  = "awsRegion"
    value = "eu-central-1"
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.cluster_autoscaler_iam_role.arn}"
  }
  # Additional Arguments (Optional) - To Test How to pass Extra Args for Cluster Autoscaler
  #set {
  #  name = "extraArgs.scan-interval"
  #  value = "20s"
  #}    
   
}
