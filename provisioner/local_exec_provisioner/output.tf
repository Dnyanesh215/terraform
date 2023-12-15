output "public-ip" {
  description = "instance public ip"
  value       = aws_instance.my-ec2.public_ip
}
