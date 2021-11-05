#!/bin/bash

sudo apt update && sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y

sudo systemctl status docker && sudo systemctl enable docker
sudo docker pull dockercloud/hello-world:latest
sudo docker run -p 80:80 dockercloud/hello-world:latest
