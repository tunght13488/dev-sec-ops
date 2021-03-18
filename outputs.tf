output "id" {
  value = aws_eks_cluster.devsecops_eks.id
}

output "status" {
  value = aws_eks_cluster.devsecops_eks.status
}

output "endpoint" {
  value = aws_eks_cluster.devsecops_eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.devsecops_eks.certificate_authority[0].data
}

output "nodegroup-details" {
  value = aws_eks_node_group.eks_ng.id
}

output "vpc-details" {
  value = aws_vpc.eks_vpc.id
}

output "codebuild-role" {
  value = "aws_iam_role.codebuild_role.arn"
}
