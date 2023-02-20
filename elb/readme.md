---
title: AWS LB for EKS
description: Create AWS load balancer for eks by terraform
---

## Introduction  
1. Create EKS Cluster
2. Create Public EKS Node Group
3. Create Private EKS Node Group
4. Review the Sample Application Kubernetes Manifests wich in k8s/
5. Deploy sample application and verify
6. Clean-Up (Sample Application and EKS Cluster and Node Groups)



## Create policy and roles requierd to aws lb

- **File:** `lbc-datasource-mainfests.tf` 

## Verify Terraform configs to create aws load balancer by terraform

- **File:** `helmprovider.tf`

## Create EKS externaldns with all configs

- **File:** `external-dns.tf`

## access output of eks cluster by remote state data source

- **File:** `remote-state.tf`




##   Execute Terraform Commands

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