resource "aws_subnet" "eks_subnet_public_1a" {

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = format("%sa", var.region)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-subnet-public-1a", var.cluster_name)
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

}

resource "aws_subnet" "eks_subnet_public_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = format("%sb", var.region)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-subnet-public-1b", var.cluster_name)
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

}

resource "aws_route_table_association" "eks_public_rt_association_1a" {
  subnet_id      = aws_subnet.eks_subnet_public_1a.id
  route_table_id = aws_route_table.eks_public_rt.id
}

resource "aws_route_table_association" "eks_public_rt_association_1b" {
  subnet_id      = aws_subnet.eks_subnet_public_1b.id
  route_table_id = aws_route_table.eks_public_rt.id
}