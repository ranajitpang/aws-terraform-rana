#!/bin/bash
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
IP_ADDR=$(curl http://169.254.169.254/latest/meta-data/public-ipv4) 
echo "Manual instance with server2 IP $IP_ADDR" > /var/www/html/index.html 
echo "ok" > /var/www/html/health.html