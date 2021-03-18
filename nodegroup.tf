resource "aws_eks_node_group" "eks_ng" {
  cluster_name    = aws_eks_cluster.devsecops_eks.name
  node_group_name = "eks_ng"
  node_role_arn   = aws_iam_role.devsecops_iam.arn
  subnet_ids      = [aws_subnet.eks_subnet1.id, aws_subnet.eks_subnet2.id, aws_subnet.eks_subnet3.id]

  scaling_config {
    desired_size = 1
    max_size     = 6
    min_size     = 1
  }

  tags = {
    Name = "eks_ng"
  }
  labels = {}
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
