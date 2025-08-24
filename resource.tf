# created a common VPC and IGW
resource "aws_vpc" "tf_aws_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_aws_vpc.id
  tags = {
    Name = "tf_igw"
  }
}

resource "aws_subnet" "tf_public_subnets" {
  for_each          = { for subnet in var.public_subnets : subnet.name => subnet }
  vpc_id            = aws_vpc.tf_aws_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "tf_private_subnets" {
  for_each          = { for subnet in var.private_subnets : subnet.name => subnet }
  vpc_id            = aws_vpc.tf_aws_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = each.value.name
  }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.tf_aws_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
  tags = {
    Name = "tf-public-rt"
  }
}

resource "aws_route_table_association" "tf_public_rta" {
  for_each       = aws_subnet.tf_public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_nat_gateway" "tf_nat_gw" {
  allocation_id = aws_eip.tf_nat_eip.id
  subnet_id     = element(values(aws_subnet.tf_public_subnets)[*].id, 0)
  tags = {
    Name = "tf-nat-gw"
  }
}