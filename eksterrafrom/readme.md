---
title: EKS Cluster and Node Groups using Terraform
description: Create AWS EKS Cluster and Node Groups using Terraform
---

## Introduction  
1. Create EKS Cluster
2. Create Public EKS Node Group
3. Create Private EKS Node Group
4. Review the Sample Application Kubernetes Manifests
5. Deploy sample application and verify
6. Clean-Up (Sample Application and EKS Cluster and Node Groups)



## Create EKS cluster iam policy and roles required

- **File:** `eks-cluster-iam-role.tf` 

## Verify Terraform configs to create eks cluster

- **File:** `eks-cluster-create.tf`

## Create EKS worker nodes iam policy and roles required

- **File:** `eks-node-group-iam.tf`

## Create EKS worker NODES

- **File:** `eks-node-group.tf`


## Create EKS Output which required in another Projects

- **File:** `eksoutput.tf`

##  Create EKS Cluster: Execute Terraform Commands

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



# UPDATE kubeconfig
```t
# Configure kubeconfig for kubectl
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region eu-central-1 update-kubeconfig --name eksdemo1

# List Worker Nodes
kubectl get nodes
kubectl get nodes -o wide

# Verify Services
kubectl get svc
```