
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${local.name}-${var.nodegroup_name}"
  node_role_arn   = var.iam_nodegroup_role_arn
  subnet_ids      = local.node_group_subnet
  version         = var.cluster_version
  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = 20
  instance_types = var.instance_types
   

  remote_access {
    ec2_ssh_key = var.key_name
  }

  scaling_config {
    max_size     = 2
    min_size     = 1
    desired_size = 1
  }

  update_config {
    max_unavailable = 1
  }
  labels = {
    Environment = var.environment
    Project     =  var.project_name
  }
  tags       = merge(local.common_tags, { Name = "${local.name}-${var.nodegroup_name}" })

  # depends_on = [aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  #   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  # aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,aws_iam_role.eks_nodegroup_role]
}