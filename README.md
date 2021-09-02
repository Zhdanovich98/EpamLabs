### Task 8: Configuration Management ###
#### In this task: ####
-   installed [Ansible](https://docs.ansible.com/), [Molecule](https://molecule.readthedocs.io/en/latest/)
-   created a virtual machine using [Vagrant](https://www.vagrantup.com/docs)
-   created a role (*docker installation, configuring the daemon to use an unsafe registry setting*) using Ansible.
-   created tests using molecule(*testing the start of the docker service, testing the contents of the daemon.json file*)
---
#### For start tests: ####
1.   clone the project from git:
```sh
git clone https://github.com/Zhdanovich98/EpamLabs.git
```
2.   go to the project directory
```sh
cd ./EpamLabs
```
3.    go to the "task8" branch
```sh
git checkout task8
```
4.   go to the playbook  directory
```sh
cd ./provision
```
5.   run tests:
```sh
molecule create && molecule converge && molecule verify
```
