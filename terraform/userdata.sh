#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<html><head><title>EC2 Hostname</title></head><body><h1>Hostname: $(hostname)</h1></body></html>" | sudo tee / usr/share/nginx/html/index.html


