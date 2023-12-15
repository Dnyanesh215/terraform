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

  provisioner "local-exec" {
    command     = "echo ${aws_instance.my-ec2.private_ip} >> creation-time-private-ip.txt"
    working_dir = "local-exec-output-files/"
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "echo Destroy-time provisioner Instanace Destroyed at `date` >> destroy-time.txt"
    working_dir = "local-exec-output-files/"
  }
}
