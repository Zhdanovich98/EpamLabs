### Task 5: "Jenkins pipelines, Nexus" ###
#### This Jenkinsfile: ####
-   clone java application from github with gradle files([task4](https://github.com/Zhdanovich98/EpamLabs/tree/task4))
> *stage: 'clone'*
-   build project(increment version, build war, upload to nexus)
> *stages: 'up version', 'build', 'load to nexus'*
>
> *nexus is located at 192.168.1.6:8081*
-   download war from nexus on server1/server2(workers with tomcat)
> *stage: 'load from nexus to server2/server3'*
-   deploy into server1/server2
> *stages: 'update tomcat from server2', 'update tomcat from server3'*
-   push changes to github, add tag with version from gradle.properties
> *stage: 'git'*
-   removes the working directory
---
