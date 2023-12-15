resource "aws_instance" "my-ec2" {
  ami           = "ami-074f77adfeee318d3"
  instance_type = "t2.micro"
  key_name      = "Linux"
  tags = {
   Name = "web-1"
  }
  lifecycle {
   #prevent_destroy = true
  }
}

