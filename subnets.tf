resource "aws_subnet" "eks_subnet1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "eks_subnet1"
  }
}

resource "aws_subnet" "eks_subnet2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "eks_subnet2"
  }
}

resource "aws_subnet" "eks_subnet3" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "eks_subnet3"
  }
}
