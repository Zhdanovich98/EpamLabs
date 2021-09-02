### Task 5: "Jenkins pipelines, Nexus" ###
#### This Jenkinsfile: ####
-   clones java application from github with gradle files([task4](https://github.com/Zhdanovich98/EpamLabs/tree/task4))
> *stage: 'clone'*
-   builds project(increment version, build war, upload to nexus)
> *stages: 'up version', 'build', 'load to nexus'*
>
> *nexus is located at 192.168.1.6:8081*
-   downloads war from nexus on server2/server3(workers with tomcat)
> *stage: 'load from nexus to server2/server3'*
-   deploys into server2/server3
> *stages: 'update tomcat from server2', 'update tomcat from server3'*
-   pushs changes to github, add tag with version from gradle.properties
> *stage: 'git'*
-   removes the working directory
---
