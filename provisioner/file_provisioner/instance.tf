resource "aws_instance" "my-ec2" {
  ami                    = "ami-074f77adfeee318d3"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-a.id
  key_name               = "Linux"
  vpc_security_group_ids = [aws_security_group.vpc-a-sg.id]
  user_data              = file("httpd.sh")
  tags = {
    Name = "httpd-server"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("/mnt/linux.pem")
  }

  provisioner "file" {
    source      = "app1"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "app2"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }
}
