variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "project_name" {
  type        = string
  description = "Project name"
}


variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
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

variable "public_nodegroup_name" {
  type        = string
  description = "NodeGroup"
}

variable "private_nodegroup_name" {
  type        = string
  description = "NodeGroup"
}

variable "ami_type" {
  type        = string
  description = "Nodegroup AMI Type"
}

variable "capacity_type" {
  type        = string
  description = "Capacity Type"
}

variable "instance_types" {
  type        = list(string)
  description = "Instance Types"
}

variable "instance_type_bastion" {
  type = string
  description = "bastion host instance type"
}

variable "allowed_ssh_cidr_blocks" {
  type = string
  description = "Allow cidr block bastion host"
}