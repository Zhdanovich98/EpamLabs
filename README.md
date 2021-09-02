### Task 6: "Containers (Docker engine, Docker compose)" ###
#### This Jenkinsfile: ####
-   clones java application from github with gradle files and dockerfile([task4](https://github.com/Zhdanovich98/EpamLabs/tree/task4))
> *stage: 'clone'*
-   builds project(increment version, build war, upload to nexus)
> *stages: 'up version', 'build', 'load to nexus'*
>
> *nexus is located at 192.168.1.6:8081*
-   builds docker image and publishes it to docker registry(docker build, docker tag, docker push)
> *stage: 'build docker image && add tag && publish image to docker registry'*
>
> *docker registry is located at 192.168.1.6:5000*
-   creates or updates swarm service(docker service create, docker service update)
> *stages: 'update swarm service3', 'create swarm service'*
-   validates deploy of service(with curl)
> *stage: 'check version on server'*
-   pushes changes to github, addes tag with version from gradle.properties
> *stage: 'git'*
-   removes the working directory
---
