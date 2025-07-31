variable "environment" {
  type        = string
  description = "Environment name"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "eks_oidc_root_ca_thumbprint" {
  type = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "eks_cluster_identity_oids_issuer" {
  type = string
  description = "eks cluster identity_oids_issuer"
}