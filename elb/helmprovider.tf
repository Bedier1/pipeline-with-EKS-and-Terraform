
/*
This code configures the Helm provider to use an AWS EKS cluster.
 It uses the Terraform Remote State data source to retrieve the cluster ID,
  endpoint, and certificate authority data. 
  It also uses the AWS EKS Cluster Auth data source to retrieve a token. 
  The code then creates a Helm Release resource named 
  "aws-load-balancer-controller" from the repository "https://aws.github.io/eks-charts". 
  The chart is set to "aws-load-balancer-controller" and is assigned to the namespace "kube-system". Several settings are configured for this release, 
  including image repository, service account name, 
  service account annotations, VPC ID, region, and cluster name.
*/
data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# HELM Provider
provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
resource "helm_release" "lbc" {
    depends_on = [aws_iam_role.lbc_role]
    name = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart = "aws-load-balancer-controller"
    namespace = "kube-system"
    set {
      name = "image.repository"
      value = "602401143452.dkr.ecr.eu-central-1.amazonaws.com/amazon/aws-load-balancer-controller"
     
    }
     set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" 
    value = "${aws_iam_role.lbc_role.arn}"
  }

  set {
    name  = "vpcId"
    value = "${data.terraform_remote_state.eks.outputs.vpc_id}"
  }  

  set {
    name  = "region"
    value = "eu-central-1"
  }    

  set {
    name  = "clusterName"
    value = data.terraform_remote_state.eks.outputs.cluster_id
  }    
}