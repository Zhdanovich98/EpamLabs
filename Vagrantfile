# -*- mode: ruby -*-
# vi: set ft=ruby :
$mach_quant = 2

Vagrant.configure("2") do |config|
  config.vm.define "server1" do |subconfig|
    subconfig.vm.box = "minimal/centos7"
    subconfig.vm.box_version = "7.0"
    subconfig.vm.network "private_network", ip: "192.168.1.1"
    subconfig.vm.network "forwarded_port", guest: 80, host: 8080
    subconfig.vm.provision "file", source: "./conf_server1/httpd.conf", destination: "./httpd.conf"
    subconfig.vm.provision "file", source: "./conf_server1/workers.properties", destination: "./workers.properties"
    subconfig.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum install mc -y
      sudo yum install httpd -y
      sudo yum install httpd-devel -y
      sudo yum install wget -y
      sudo systemctl start httpd
      sudo systemctl enable httpd
    SHELL
  end
  
(1..$mach_quant).each do |i|
  config.vm.define "server#{1+i}" do |subconfig|
    subconfig.vm.box = "minimal/centos7"
    subconfig.vm.box_version = "7.0"
    subconfig.vm.network "private_network", ip: "192.168.1.#{1+i}"
    subconfig.vm.network "forwarded_port", guest: "8080", host: "808#{1+i}"
    config.env.enable

    subconfig.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum install mc -y
      sudo yum install tomcat -y
      sudo yum install tomcat-webapps tomcat-admin-webapps -y
      sudo systemctl start tomcat
      sudo systemctl restart tomcat
      sudo systemctl enable tomcat
      sudo systemctl status tomcat
      sudo rm /usr/share/tomcat/webapps/ROOT/index.jsp
      sudo rm /usr/share/tomcat/webapps/ROOT/index.html
      sudo touch index.html
      echo "<html>" >> /usr/share/tomcat/webapps/ROOT/index.html
      echo "<header><title>This is server</title></header>" >> /usr/share/tomcat/webapps/ROOT/index.html
      echo "<body>" >> /usr/share/tomcat/webapps/ROOT/index.html
      echo "SERVER #{1+i}" >> /usr/share/tomcat/webapps/ROOT/index.html
      echo "</body>" >> /usr/share/tomcat/webapps/ROOT/index.html
      echo "</html>" >> /usr/share/tomcat/webapps/ROOT/index.html
      echo "complete add index.html"
    SHELL
  end
end  
  
end
