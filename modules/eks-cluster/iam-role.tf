
resource "aws_iam_role" "EKSClusterRole" {

  name        = "${local.name}-EKSClusterRole"
  assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statements = [{
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
            Service = "eks.amazonaws.com"
        }
     }]
  })
}

