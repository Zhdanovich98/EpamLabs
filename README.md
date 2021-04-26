### Task 2: "VCS (Git), VirtualBox, Vagrant" ###
#### This Vagrantfile: ####
-   creates 2 virtual machines (CentOS 7 minimal): *"server1", "server2"*
-   install git on server1
-   clones the project from the git repository
-   print to console content of text file from task2 branches
-   edits the hosts file using the "[vagrant-hosts](https://github.com/oscar-stack/vagrant-hosts.git)"
---
#### For start: ####
1.   clone the project from git:
```sh
git clone https://github.com/Zhdanovich98/EpamLabs.git
```
2.   install the "vagrant-hosts" plugin:
```sh
vagrant plugin install vagrant-hosts
```
3.   go to the project directory
```sh
cd ./EpamLabs
```
4.   go to the "task2" branch
```sh
git checkout task2
```
5.   start Vagrantfile:
```sh
vagrant up
```
