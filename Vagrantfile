# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "task8" do |subconfig|
    subconfig.vm.box = "bento/ubuntu-18.04"
    subconfig.vm.network "private_network", ip: "192.168.1.11"
    subconfig.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "provision/playbook.yml"
      ansible.verbose = true
    end
  end
  
end
