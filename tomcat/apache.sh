#! /bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
echo "application deployed using terraform" > /var/www/html/index.html
sudo systemctl restart httpd
