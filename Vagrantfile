# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "server1" do |subconfig|
    subconfig.vm.box = "minimal/centos7"
    subconfig.vm.box_version = "7.0"
    subconfig.vm.network "private_network", ip: "192.168.1.2"

    subconfig.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum install git -y
      sudo yum install mc -y
      git clone https://github.com/Zhdanovich98/EpamLabs
      cd ./EpamLabs
      git checkout task2
      cat test.txt
    SHELL
    subconfig.vm.provision :hosts do |provisioner|
      provisioner.add_host '192.168.1.3', ['server2']
    end
  end
  config.vm.define "server2" do |subconfig|
    subconfig.vm.box = "minimal/centos7"
    subconfig.vm.box_version = "7.0"
    subconfig.vm.network "private_network", ip: "192.168.1.3"

    subconfig.vm.provision "shell", inline: <<-SHELL
      sudo yum update -y
      sudo yum install mc -y
    SHELL
    subconfig.vm.provision :hosts do |provisioner|
      provisioner.add_host '192.168.1.2', ['server1']
    end
  end
end
