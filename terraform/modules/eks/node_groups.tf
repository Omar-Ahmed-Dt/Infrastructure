resource "aws_eks_node_group" "private_cluster_ng" {
  cluster_name    = aws_eks_cluster.private_cluster.name
  node_group_name = "private_eks_ng"
  node_role_arn   = aws_iam_role.private_cluster_ng_role.arn
  subnet_ids      = var.priv_subnets
  version         = "1.23"
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key = "aws-iti-lab"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.attach-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.attach-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.attach-AmazonEC2ContainerRegistryReadOnly,
  ]
}
