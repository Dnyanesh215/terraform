sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run -itdp 8080:8080 -v /mnt:/usr/local/tomcat/webapps/ --name server-1 tomcat
