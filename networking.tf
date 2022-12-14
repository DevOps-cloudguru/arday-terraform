### VPC

resource "aws_vpc" "main" {
  cidr_block       = "10.16.0.0/16"

  tags = {
    Name = "arday_vpc"
  }
}


## subnet public
resource "aws_subnet" "main-public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"
  tags = {
    Name = "arday-public-subnet"
  }
}

### subnet private 
resource "aws_subnet" "main-private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.16.2.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "arday-private-subnet"
  }
}


## internet gateway
resource "aws_internet_gateway" "arday-ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "arday-IG"
  }
} 

## route table public
resource "aws_route_table" "arday-rt-public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "arday-tf"
  }
}

## route table and vpc/ig ass
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.arday-rt-public.id
  destination_cidr_block = "0.0.0.0/24"
  gateway_id             = aws_internet_gateway.arday-ig.id
} 

## route table association with subnet (public)
resource "aws_route_table_association" "arday-rt-public-ass" {
  subnet_id      = aws_subnet.main-public.id
  route_table_id = aws_route_table.arday-rt-public.id

}


## security group ( allows all ssh from all protocols)

resource "aws_security_group" "arday_sg" {
  name        = "dev-sg"
  description = "Arday-Developer Security group"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
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
