
## Introduction  
1. Review OIDC Provider added as Identity Provider in AWS IAM Service  
2. We are going to install EKS EBS CSI Driver as a [self-managed Add-On](https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi-self-managed-add-on.html) using Terraform
3. Create Terraform configs to install EBS CSI Driver using [HELM Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs) and [HELM Release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release). 
4. Key Resources for discission in this section
   - EBS CSI IAM Policy
   - EBS CSI IAM Role
   - Kubernetes EBS CSI Service Account
   - Kubernetes EBS CSI Controller Deployment
   - Kubernetes EBS CSI Node Daemonset
   - Terraform HELM Provider
   - Terraform HELM Release   
   - Terraform HTTP Datasource



## Access output of ekscluster

- **File:** `remotestate-data.tf` 

## Verify Terraform configs 

- **File:** `ebs-mainfests.tf`

- **File:** `helmprovider.tf`


##  Create EBS resources: Execute Terraform Commands

# Terraform Init
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply 
terraform apply -auto-approve

# List Terraform Resources 
terraform state list


## References
- [AWS IAM OIDC Connect Provider - Step-3](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html)
- [AWS EBS CSI Driver](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)
- [AWS Caller Identity Datasource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)
- [HTTP Datasource](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)
- [AWS IAM Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
- [AWS IAM Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
- [AWS EBS CSI Docker Images across Regions](https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html)
- [List All Container Images Running in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/)

