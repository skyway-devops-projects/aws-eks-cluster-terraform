module "vpc" {
  source          = "./modules/vpc"
  environment     = var.environment
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  azs             = var.availability_zones
}

module "eks" {
  source = "./modules/eks-cluster"
  environment     = var.environment
  project_name    = var.project_name
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids = module.vpc.public_subnet_ids
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr
  depends_on = [ module.vpc ]
}

module "eks_public_node_group" {
  source = "./modules/node-group"
  environment     = var.environment
  project_name    = var.project_name
  eks_cluster_name = module.eks.eks_cluster_name
  cluster_version = var.cluster_version
  instance_types = var.instance_types
  ami_type = var.ami_type
  capacity_type = var.capacity_type
  key_name = var.key_name
  nodegroup_name = var.nodegroup_name
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids = module.vpc.public_subnet_ids
  create_iam_nodegroup_roles = true
}