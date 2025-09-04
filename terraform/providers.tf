# =============================================================================
# KUBERNETES AND HELM PROVIDER CONFIGURATIONS
# =============================================================================
# These providers are configured separately to avoid circular dependencies
# They should be configured after the EKS cluster is created

data "aws_eks_cluster" "cluster" {
  name = module.retail_app_eks.cluster_name
  depends_on = [module.retail_app_eks]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.retail_app_eks.cluster_name
  depends_on = [module.retail_app_eks]
}

# =============================================================================
# PROVIDER CONFIGURATIONS
# =============================================================================

provider "aws" {
  region = var.aws_region
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}