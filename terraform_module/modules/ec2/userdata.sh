#!/bin/bash
yum -y update
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo "The page was created by the user data" | sudo tee /usr/share/nginx/html/index.html