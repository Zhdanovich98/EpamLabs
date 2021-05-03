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
    subconfig.vm.provision "shell", path: "./conf_server1/manager.sh"
  end
  
(1..$mach_quant).each do |i|
  config.vm.define "server#{1+i}" do |subconfig|
    subconfig.vm.box = "minimal/centos7"
    subconfig.vm.box_version = "7.0"
    subconfig.vm.network "private_network", ip: "192.168.1.#{1+i}"
    subconfig.vm.provision "shell", path: "./workers/workers.sh", args: "#{1+i}"
  end
end  
  
end
