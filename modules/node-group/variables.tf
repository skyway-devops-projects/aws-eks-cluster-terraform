variable "environment" {
  type        = string
  description = "Environment name"
}

variable "project_name" {
  type        = string
  description = "Project name"
}
variable "nodegroup_name" {
  type = string
  description = "Nodegroup name"
}

variable "eks_cluster_name" {
  type = string
  description = "EKS Cluster Name"
}

variable "public_subnet_ids" {
  type = list(s)
  description = "List of Public SubnetIds"
}

variable "private_subnet_ids" {
  type = list(s)
  description = "List of Private SubnetIds"
}

variable "cluster_version" {
  type = string
 description ="Kubernetes minor version to use for the EKS cluster (for example 1.21)"
}

variable "ami_type" {
  type = string
  description = "Nodegroup AMI Type"
}

variable "capacity_type" {
  type = string
  description = "Capacity Type"
}

variable "instance_types" {
  type = list(string)
  description = "Instance Types"
}

variable "key_name" {
  type = string
  description = "Key name"
}

variable "create_iam_nodegroup_roles" {
  type    = bool
  description = "define nodegroup role create or not"
}