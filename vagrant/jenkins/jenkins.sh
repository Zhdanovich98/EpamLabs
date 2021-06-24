#install jenkins
sudo yum update -y
sudo yum install mc -y
sudo yum install java-1.8.0-openjdk-devel -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
#install docker
sudo yum check-update
curl -fsSL https://get.docker.com/ | sh
sudo usermod -aG docker jenkins
sudo usermod -aG docker ${USER}
sudo systemctl start docker
sudo systemctl enable docker
#create swarm init
docker swarm init --advertise-addr 192.168.1.5:2377
