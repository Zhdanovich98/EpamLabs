### Task 6: "Containers (Docker engine, Docker compose)" ###
#### This Jenkinsfile: ####
-   clone java application from github([task4](https://github.com/Zhdanovich98/EpamLabs.git))
> *stage: 'clone'*
-   build project(increment version, build war, upload to nexus)
> *stages: 'up version', 'build', 'load to nexus'*
-   build docker image and publish it to docker registry(docker build, docker tag, docker push)
> *stage: 'build docker image && add tag && publish image to docker registry'*
>
> *docker registry is located at 192.168.1.6:5000*
-   freate or update swarm service(docker service create, docker service update)
> *stages: 'update swarm service3', 'create swarm service'*
-   validate deploy of service(with curl)
> *stage: 'check version on server'*
-   push changes to github, add tag with version from gradle.properties
> *stages: 'git'*
-   removes the working directory
---
