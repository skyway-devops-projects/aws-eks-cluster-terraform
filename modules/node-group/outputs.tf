output "node_group_public_id" {
  description = "Public Node Group ID"
  value       = aws_eks_node_group.eks_node_group.id
}

# output "node_group_public_arn" {
#   description = "Public Node Group ARN"
#   value       = aws_eks_node_group.eks_node_group.arn
# }

output "node_group_public_status" {
  description = "Public Node Group status"
  value       = aws_eks_node_group.eks_node_group.status
}

output "node_group_public_version" {
  description = "Public Node Group Kubernetes Version"
  value       = aws_eks_node_group.eks_node_group.version
}


