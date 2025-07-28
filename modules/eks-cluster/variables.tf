variable "environment" {
  type        = string
  description = "Environment name"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of Public SubnetIds"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of Private SubnetIds"
}

variable "aws_iam_role_EKSClusterRole_arn" {
  type = string
}

