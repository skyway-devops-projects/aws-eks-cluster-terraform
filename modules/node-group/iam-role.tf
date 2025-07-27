resource "aws_iam_role" "eks_nodegroup_role" {
  count =   var.create_iam_nodegroup_roles ? 0 : 1
  name = "${local.name}-eks-nodegroup-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal ={
            Service = "ec2.amazonaws.com"
        }
    }]
  })
}