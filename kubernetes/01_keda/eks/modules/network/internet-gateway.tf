resource "aws_internet_gateway" "eks_ig" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = format("%s-internet-gateway", var.cluster_name)
  }

}

resource "aws_route_table" "eks_public_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_ig.id
  }

  tags = {
    Name = format("%s-public-rt", var.cluster_name)
  }

}