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
# VARIABLES
# =============================================================================

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

# =============================================================================
# PROVIDER CONFIGURATIONS
# =============================================================================

provider "aws" {
  region = var.aws_region
}
