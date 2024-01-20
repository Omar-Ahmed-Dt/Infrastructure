resource "aws_eks_cluster" "private_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn
  version  = "1.23"
  vpc_config {
    subnet_ids              = var.priv_subnets
    endpoint_private_access = true
    endpoint_public_access  = false
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.attach_eks_role_policy,
    aws_iam_role_policy_attachment.attach-AmazonEKSVPCResourceController,
  ]
}
