resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-A"
  }
}

resource "aws_subnet" "subnet-a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-a"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route" "pub-rt" {
  route_table_id         = aws_route_table.rt.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rt-subnet" {
  route_table_id = aws_route_table.rt.id
  subnet_id      = aws_subnet.subnet-a.id
}
