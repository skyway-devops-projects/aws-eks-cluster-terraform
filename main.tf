locals {
  name = "${var.project_name}-${var.environment}"
  common_tags = {
    Environment = "${var.environment}"
    CreatedBy   = "Terraform"
  }
}


module "vpc" {
  source          = "./modules/vpc"
  environment     = var.environment
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  azs             = var.availability_zones
}


module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
    environment     = var.environment
  project_name    = var.project_name
  allowed_ssh_cidr_blocks = var.allowed_ssh_cidr_blocks
}

module "eks_cluster_iam_role" {
  source = "./modules/eks-cluser-iam-role"
   environment                          = var.environment
  project_name                         = var.project_name
}

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.amzn_linux_2023_latest.id
  instance_type          = var.instance_type_bastion
  vpc_security_group_ids = [module.security.bastion_security_group_id]
  subnet_id              = element(module.vpc.public_subnet_ids, 0)
  key_name               = var.key_name
  # iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  tags                   = merge(local.common_tags, { Name = "${local.name}-baston-host" })
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/private_key/vprofile-dev.pem")
      host        = self.public_ip
    }
    source      = "${path.module}/private_key/vprofile-dev.pem"
    destination = "/home/ec2-user/vprofile-dev.pem"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/private_key/vprofile-dev.pem")
      host        = self.public_ip
    }
    inline = [
      "chmod 400 /home/ec2-user/vprofile-dev.pem",

    ]
  }
  depends_on = [module.vpc]
}

module "eks" {
  source                               = "./modules/eks-cluster"
  environment                          = var.environment
  project_name                         = var.project_name
  cluster_name                         = var.cluster_name
  cluster_version                      = var.cluster_version
  aws_iam_role_EKSClusterRole_arn = module.eks_cluster_iam_role.eks_cluster_role_arn
  private_subnet_ids                   = module.vpc.private_subnet_ids
  public_subnet_ids                    = module.vpc.public_subnet_ids
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_service_ipv4_cidr            = var.cluster_service_ipv4_cidr
  depends_on                           = [module.vpc,module.eks_cluster_iam_role]
}

module "eks_public_node_group" {
  source                     = "./modules/node-group"
  environment                = var.environment
  project_name               = var.project_name
  eks_cluster_name           = module.eks.eks_cluster_name
  cluster_version            = var.cluster_version
  instance_types             = var.instance_types
  ami_type                   = var.ami_type
  capacity_type              = var.capacity_type
  key_name                   = var.key_name
  nodegroup_name             = var.public_nodegroup_name
  private_subnet_ids         = module.vpc.private_subnet_ids
  public_subnet_ids          = module.vpc.public_subnet_ids
  public_node_group = true
iam_nodegroup_role_arn = module.eks_cluster_iam_role.eks_cluster_node_group_arn
depends_on = [ module.eks_cluster_iam_role]
}

module "eks_private_node_group" {
  source                     = "./modules/node-group"
  environment                = var.environment
  project_name               = var.project_name
  eks_cluster_name           = module.eks.eks_cluster_name
  cluster_version            = var.cluster_version
  instance_types             = var.instance_types
  ami_type                   = var.ami_type
  capacity_type              = var.capacity_type
  key_name                   = var.key_name
  nodegroup_name             = var.private_nodegroup_name
  private_subnet_ids         = module.vpc.private_subnet_ids
  public_subnet_ids          = module.vpc.public_subnet_ids
  public_node_group = false
iam_nodegroup_role_arn = module.eks_cluster_iam_role.eks_cluster_node_group_arn
depends_on = [ module.eks_cluster_iam_role]
}

