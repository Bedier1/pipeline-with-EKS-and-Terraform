# Pipeline-with-EKS-and-Terrafrom(end-to-end)

This project is a demonstration of creating an Amazon Elastic Kubernetes Service (EKS) cluster from scratch using Terraform, implementing various add-ons like EBS, EFS, AWS Load Balancer, Cluster Auto Scaler, and  HTTP to HTTPS. In addition, this project also includes setting up a CI/CD pipeline to deploy a Java management API to call a database, using Jenkins to create this pipeline, containerizing the code with Dockerfile, and implementing Prometheus and Grafana to monitor the Kubernetes cluster.

## Prerequisites

To run this project, you must have the following prerequisites:

- An AWS account
- Terraform installed
- kubectl installed
- Docker installed
- Jenkins installed


## Project Structure

- `eksterraform` directory contains the Terraform code to create an EKS cluster from scratch. This includes creating the VPC, subnets, security groups, and other required resources.
- `ebs` directory contains the Terraform code to create the Elastic Block Storage (EBS) add-on for the EKS cluster. This allows the EKS cluster to use persistent volumes backed by Amazon EBS.
- `efs` directory contains the Terraform code to create the Elastic File System (EFS) add-on for the EKS cluster. This allows the EKS cluster to use persistent volumes backed by Amazon EFS.
- `elb` directory contains the Terraform code to create the AWS Load Balancer add-on for the EKS cluster. This allows the EKS cluster to distribute incoming traffic to the Kubernetes pods running in the cluster.
- `kubernetes-src-code` directory contains the source code for the Java management API, which is deployed using the CI/CD pipeline in Jenkins.
- `users-withgroups` directory contains the kubeconfig file for administrators to access the EKS cluster. This file is created by creating a group with EKS full access and STS assume role, and adding users to this group to allow them to assume the role and talk to EKS.

## Getting Started

1. Clone this repository to your local machine.
2. Configure the `eks-vars.tf` file with your AWS credentials, region, and other required variables.
3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform plan` to see the planned changes.
5. Run `terraform apply` to apply the changes and create the EKS cluster.
6. Once the EKS cluster is created,update kubeconfig by using `aws eks --region eu-central-1 update-kubeconfig --name cluster_name` , run `kubectl apply -f <yaml-file>` to apply the YAML files for add-ons and other configurations.
7. Set up the CI/CD pipeline in Jenkins and connect it to the GitHub repository.
8. Containerize the code using Dockerfile and push it to Docker Hub or any other container registry.
9. Monitor the Kubernetes cluster using Prometheus and Grafana.

## References

- [Amazon EKS](https://aws.amazon.com/eks/)
- [Terraform](https://www.terraform.io/)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
- [Docker](https://www.docker.com/)
- [Jenkins](https://www.jenkins.io/)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)
