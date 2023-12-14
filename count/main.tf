resource "aws_instance" "my-ec2" {
  ami           = "ami-074f77adfeee318d3"
  instance_type = "t2.micro"
  count         = 3
  tags = {
    Name = "web-${count.index}"
  }
}
