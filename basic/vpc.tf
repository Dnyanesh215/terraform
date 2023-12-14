resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-A"
  }
}

resource "aws_subnet" "subnet-a" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.my-vpc.id
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-a"
  }
}

resource "aws_internet_gateway" "vpc-a-igw" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route" "internet-route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-a-igw.id
}

resource "aws_route_table_association" "sub-rt" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.subnet-a.id
}

resource "aws_security_group" "vpc-a-sg" {
  name        = "vpc-a-sg"
  description = "ssh connection"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "allow all out bound ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

