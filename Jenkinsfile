pipeline {
    agent any
    tools {
        gradle 'gradle'
    }
    stages {
       stage('clone prroject') {
            steps {
                git branch: 'task4', credentialsId: 'git_ssh', url: 'git@github.com:Zhdanovich98/EpamLabs.git'
            }
        }
        stage('up version') {
            steps {
                sh 'gradle up_version'
            }
        }
        stage('build project') {
            steps {
                sh 'gradle build'
            }
        }
        stage('load to nexus') {
            environment {
                VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
              }
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'test', classifier: '', file: './build/libs/ep-task.war', type: 'war']], credentialsId: 'admin', groupId: 'snapshots', nexusUrl: '192.168.1.6:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'maven', version: env.VERSION
            }
        }
        stage('build docker image && add tag && publish image to docker registry') {
            environment {
                VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
                }
            steps {
                sh 'docker build --build-arg version_variable=$VERSION -t task6:$VERSION .'
                sh 'docker tag task6:$VERSION 192.168.1.6:5000/task6:$VERSION'
                sh 'docker push 192.168.1.6:5000/task6:$VERSION'
            }
        }
        stage('update swarm service') {
            environment {
                VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
                }
            steps {
                script {
                int i = 0;
                def part = sh(script: 'docker service ls', returnStdout: true).trim().split(" ");
                while(i!=part.length){
                if (part[i] == "task6"){
                    sh 'docker service update  --publish-add published=8082,target=8080 --replicas 1 --image 192.168.1.6:5000/task6:$VERSION task6'
                    skipCreateServiceStages = true
                    break;
                } else {
                    skipCreateServiceStages = false
                }
                i++;
                }
                }
            }
        }
        stage('create swarm service') {
            environment {
                VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
                }
            when {
                expression {
                    skipCreateServiceStages != true
                }
            }
            steps {
                sh 'docker service create --name task6  --publish published=8082,target=8080 --replicas 1 192.168.1.6:5000/task6:$VERSION'
            }
        }
        
        stage('check version on server') {
            environment {
                   VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
                }
            steps {
                script {
                def part1 = sh(script: 'curl -s http://192.168.1.5:8082 | grep "<p>"', returnStdout: true).trim().split("<")
                def part2 = part1[1].split(">")
                if (part2[1] == env.VERSION) {
                    println "verify match";
                } else {
                    currentBuild.result = 'ABORTED'
                    error('the versions do not match')
                }
                }
            }
        }
         stage('git') {
            environment {
                    VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
                }
            steps {
                sshagent(['git_ssh']) {
                    sh 'git config user.email "you@gmain.com"'
                    sh 'git config user.name "Zhdanovich98"'
                    sh 'git add gradle.properties'
                    sh 'git commit -m "update to $VERSION"'
                    sh 'git tag v$VERSION'
                    sh 'git push origin task4'
                    sh 'git push origin v$VERSION'
                }
            }
        }
    }
    post {
        always {
            script {    
            step([$class: 'WsCleanup'])
       }
    }
}
}
