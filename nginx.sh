#!/bin/bash

sudo apt update && sudo apt install nginx -y
sudo systemctl enable nginx
command="curl http://169.254.169.254/latest/meta-data/local-ipv4"
myip=$($command)
sudo echo "<h1>Hello, World with ip: $myip!</h1" | sudo tee -a /var/www/html/index.html
sudo systemctl restart nginx
