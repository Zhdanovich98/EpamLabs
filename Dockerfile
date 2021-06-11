FROM tomcat:10.0.6-jdk16-openjdk-buster

ARG version_variable='1.0.10'

ENV VERSION=$version_variable
ENV NEXUS_URL='http://192.168.1.6:8081/nexus/content/repositories/maven/snapshots/test/'$VERSION'/test-'$VERSION'.war'

RUN echo $NEXUS_URL

ADD $NEXUS_URL /usr/local/tomcat/ep-task.war
RUN unzip -q /usr/local/tomcat/ep-task.war -d /usr/local/tomcat/webapps/ROOT
RUN rm /usr/local/tomcat/ep-task.war