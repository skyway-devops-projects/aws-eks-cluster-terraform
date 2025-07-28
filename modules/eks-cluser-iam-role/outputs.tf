output "eks_cluster_role_arn" {
  value = aws_iam_role.EKSClusterRole.arn
}

output "eks_cluster_node_group_arn" {
  value = aws_iam_role.eks_nodegroup_role.arn
}