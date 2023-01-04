###--Networking Module/File

### VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "arday_vpc"
  }
}

## Public Subnets
resource "aws_subnet" "main-public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name = "arday-public-sn"
  }
}

### Private Subnets
resource "aws_subnet" "main-private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.16.2.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "arday-private-sn"
  }
}

## internet gateway
resource "aws_internet_gateway" "arday-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "arday-IGW"
  }
}

## Public route table
resource "aws_route_table" "arday-rt-public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "arday-rt"
  }
}

## Default route table and IGW association
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.arday-rt-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.arday-ig.id
}

## Public subnet association
resource "aws_route_table_association" "arday-rt-public-ass" {
  subnet_id      = aws_subnet.main-public.id
  route_table_id = aws_route_table.arday-rt-public.id
}

## security group ( allows all ssh from all protocols)
resource "aws_security_group" "arday_sg" {
  name        = "arday-sg"
  description = "Arday-DevOps Security group"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-"
    # cidr_blocks = ["1.1.1.1/32"] # /32 to ensure only that IP is allowed
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
