resource "aws_eks_cluster" "devsecops_eks" {
  name     = "abhilash"
  role_arn = aws_iam_role.devsecops_iam.arn

  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet1.id, aws_subnet.eks_subnet2.id, aws_subnet.eks_subnet3.id]
  }
  
  version = "1.19"
  tags = { 
       "Name" = "abhilash"
       "Application" = "Devsecops"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]

}

