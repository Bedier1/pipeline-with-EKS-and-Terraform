# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.12"
     }
    helm = {
      source = "hashicorp/helm"
      #version = "2.5.1"
    }
    http = {
      source = "hashicorp/http"
      #version = "2.1.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }      
  }
  # Adding Backend as S3 for Remote State Storage
  
}

# Terraform AWS Provider Block
provider "aws" {
  region = "eu-central-1"
}

# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}
provider "kubernetes" {
  
}
