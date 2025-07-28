# data "aws_iam_role" "existing_node_role" {
#   count = var.create_iam_nodegroup_roles ? 0 : 1   
#   name  = "${local.name}-eks-nodegroup-role"
# }