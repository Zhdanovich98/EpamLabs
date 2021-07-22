### Task 9: Continuous Delivery with Jenkins, Ansible, Docker" ###
#### This task have Ansible roles who: ####
-   installs nginx web server([LB](https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/)) and configures it to route traffic to 8082 or 8083 ports
-   installs [doсker](https://docs.docker.com/) 
-   configures the daemon docker to use an [insecure-registry](https://docs.docker.com/registry/insecure/) option
-   deploys a [new version](https://github.com/Zhdanovich98/EpamLabs/tags) of the container to an available port (8082 or 8083)
-   stops and removes the old container
---
#### This task have Jenkins CD job who: ####
-   has the ability to select a version from the docker registry using [Active Choices plugin](https://plugins.jenkins.io/uno-choice/)
-   checkout [task9](https://github.com/Zhdanovich98/EpamLabs/tree/task9) branch from github repository
-   pass the version as a variable to the available play and run it
---
#### For start: ####
1.   install Active Choices plugin for Jenkins
2.   in Jenkins, go to "create item", after "Create a task with free configuration"
3.   select the item "This is a parameterized assembly"
4.   select "Active Choices Parameter" from the drop-down list, fill in the fields: 
```sh
Name: version
Groovy Script: //use script from groovy.script file which is stored in git repository
```
5.   select "Source code management", choose "Git", fill in the fields: 
```sh
Repository URL: https://github.com/Zhdanovich98/ServletWebLogic.git
Branch Specifier: */task9
```
6.   under "Assembly" select "Execute shell command", fill in the fields:  
```sh
Team: //use script from command.sh file which is stored in git repository
```
7.   under "Post-assembly operations" select "Delete workspace when build is done".  

