resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  count =   var.create_iam_nodegroup_roles ? 0 : 1
  role = aws_iam_role.eks_nodegroup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  count =   var.create_iam_nodegroup_roles ? 0 : 1
  role = aws_iam_role.eks_nodegroup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  count =   var.create_iam_nodegroup_roles ? 0 : 1
  role = aws_iam_role.eks_nodegroup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}