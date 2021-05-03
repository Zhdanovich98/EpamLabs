### Task 3: "Load balancing with Apache Httpd, Tomcat" ###
#### This Vagrantfile: ####
-   creates 3 virtual machines (CentOS 7 minimal): *"server1", "server2", "server3"*
-   install Apache httpd on *"server1"*
-   install Apache Tomcat on *"server2"* and *"server3"*
-   create index.html for *"server2"* and *"server3"*
-   configures loadbalancer on *"server1"*
-   display status loadbalancer on address *http://localhost:8080/jkmanager/*
---
#### For start: ####
1.   clone the project from git:
```sh
git clone https://github.com/Zhdanovich98/EpamLabs.git
```
2.   go to the project directory
```sh
cd ./EpamLabs
```
3.    go to the "task3" branch
```sh
git checkout task2
```
4.   start Vagrantfile:
```sh
vagrant up
```
5.   checking port 8080
