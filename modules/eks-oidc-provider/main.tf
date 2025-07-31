data "aws_partition" "current" {}



resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list = [ "sts.${data.aws_partition.current.dns_suffix}" ]
  thumbprint_list = [ var.eks_oidc_root_ca_thumbprint ]
  url = var.eks_cluster_identity_oids_issuer
    tags = merge(local.common_tags, { Name = "${local.name}-eks-irsa" })
}