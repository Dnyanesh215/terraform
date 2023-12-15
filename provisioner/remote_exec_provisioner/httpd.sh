#!/bin/bash

sudo yum update -y && sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "Application deployed by Teraform" > /var/www/html/index.html
sudo chmod -R 777 /mnt
