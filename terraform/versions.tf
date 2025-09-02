# =============================================================================
# TERRAFORM AND PROVIDER VERSIONS
# =============================================================================

terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69"   # Latest 5.x release
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.14"   # Latest 2.x release
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.34"   # Latest 2.x release
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11"   # Latest 0.11.x release
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"    # Latest 3.2.x release
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"    # Latest 3.6.x release
    }
  }
}

# =============================================================================
# PROVIDER CONFIGURATIONS
# =============================================================================

provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    host                   = module.retail_app_eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.retail_app_eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.retail_app_eks.cluster_name]
    }
  }
}

provider "kubernetes" {
  host                   = module.retail_app_eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.retail_app_eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.retail_app_eks.cluster_name]
  }
}
