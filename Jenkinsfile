pipeline {
    agent any
    tools {
        gradle 'gradle'
    }
    stages {
       stage('clone') {
            steps {
                git branch: 'task4', credentialsId: 'git_ssh', url: 'git@github.com:Zhdanovich98/EpamLabs.git'
            }
        }
        stage('up version') {
            steps {
                sh 'gradle up_version'
            }
        }
        stage('build') {
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
        stage('load from nexus to server2/server3') {
           environment {
                   VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
                   ARTIFACT_URL = "http://192.168.1.6:8081/nexus/content/repositories/maven/snapshots/test/$VERSION/test-$VERSION"+"."+"war"
              }
            steps {
                sshagent(['jenkins_ssh']) {
                    sh "ssh -o StrictHostKeyChecking=no -v -i /var/lib/jenkins/.ssh/id_rsa vagrant@192.168.1.2 'wget $ARTIFACT_URL && unzip test-$VERSION"+"."+"war -d ROOT && rm test-$VERSION"+"."+"war'"
                    sh "ssh -o StrictHostKeyChecking=no -v -i /var/lib/jenkins/.ssh/id_rsa vagrant@192.168.1.3 'wget $ARTIFACT_URL && unzip test-$VERSION"+"."+"war -d ROOT && rm test-$VERSION"+"."+"war'"
                }
            }
        }
        stage('update tomcat from server2/server3') {
            steps {
                sshagent(['jenkins_ssh']) {
                    sh "ssh -o StrictHostKeyChecking=no -v -i /var/lib/jenkins/.ssh/id_rsa vagrant@192.168.1.2 'sudo rm -R /var/lib/tomcat/webapps/ROOT && sudo mv /home/vagrant/ROOT /var/lib/tomcat/webapps/ROOT && sudo systemctl restart tomcat'"
                    sh "ssh -o StrictHostKeyChecking=no -v -i /var/lib/jenkins/.ssh/id_rsa vagrant@192.168.1.3 'sudo rm -R /var/lib/tomcat/webapps/ROOT && sudo mv /home/vagrant/ROOT /var/lib/tomcat/webapps/ROOT && sudo systemctl restart tomcat'"
                }
            }
        }
        stage('check version on servers') {
           environment {
                   VERSION = sh(returnStdout: true, script: 'cat ./gradle.properties | grep version | cut -d"=" -f2').trim()
                }
            steps {
                script {
                int i = 1;
                while(i<=2) {
                def part1 = sh(script: 'curl -s http://192.168.1.'+(1+i)+':8080 | grep "<p>"', returnStdout: true).trim().split("<")
                def part2 = part1[1].split(">")
                if (part2[1] == env.VERSION) {
                    println "verify match";
                    i++;
                } else {
                    currentBuild.result = 'ABORTED'
                    error('the versions do not match')
                }
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
