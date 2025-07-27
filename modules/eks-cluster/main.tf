# Create AWS EKS Cluster

resource "aws_eks_cluster" "eks_cluster" {
  name = "${local.name}-${var.cluster_name}"
  version = var.cluster_version
  role_arn = aws_iam_role.EKSClusterRole.arn
  vpc_config {
    subnet_ids = var.public_subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access = var.cluster_endpoint_public_access
    public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  }
  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }
   # Enable EKS Cluster Control Plane Logging
  enabled_cluster_log_types = [ "api", "audit", "authenticator", "controllerManager", "scheduler" ]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [ aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  aws_iam_role_policy_attachment.AmazonEKSVPCResourceController ]
}