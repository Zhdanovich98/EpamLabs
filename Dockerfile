FROM tomcat:latest

ARG version_variable='1.0.10'

ENV VERSION=$version_variable
ENV NEXUS_URL='http://192.168.1.6:8081/nexus/content/repositories/maven/snapshots/test/'$VERSION'/test-'$VERSION'.war'

RUN echo $VERSION
RUN echo $NEXUS_URL

ADD $NEXUS_URL /usr/local/tomcat/webapps/task6.war