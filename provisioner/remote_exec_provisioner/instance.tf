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
    source      = "app.html"
    destination = "/tmp/app.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 120",
      "sudo cp /tmp/app.html /mnt",
      "sudo cp /mnt/app.html /var/www/html"
    ]
  }
}
