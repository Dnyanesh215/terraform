resource "aws_instance" "my-ec2" {
  ami                    = "ami-074f77adfeee318d3"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-a.id
  key_name               = "Linux"
  vpc_security_group_ids = [aws_security_group.vpc-sg.id]
  user_data              = file("apache.sh")
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
    source      = "docker.sh"
    destination = "/tmp/docker.sh"
  }

  provisioner "file" {
    source      = "sample.war"
    destination = "/tmp/sample.war"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "chmod -R 777 /mnt",
      "sudo cp /tmp/sample.war /mnt",
      "chmod -R 777 /tmp",
      "cd /tmp && ./docker.sh"
    ]
  }
}
