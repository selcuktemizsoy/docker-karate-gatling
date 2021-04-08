FROM ubuntu:16.04

USER root
RUN apt-get update && apt-get install -y \
software-properties-common

RUN mkdir /usr/loadtest
WORKDIR /usr/loadtest
COPY . /usr/loadtest



# Add the "JAVA" ppa
RUN add-apt-repository -y \
ppa:webupd8team/java


# Install OpenJDK-8
RUN apt-get update && \
apt-get install -y openjdk-8-jdk && \
apt-get install -y ant && \
apt-get clean;



# Fix certificate issues
RUN apt-get update && \
apt-get install ca-certificates-java && \
apt-get clean && \
update-ca-certificates -f;



RUN apt-get update && \
apt-get install -y maven




RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN export MAVEN_HOME=/usr/share/maven
RUN export M2_HOME=/usr/share/maven
RUN export PATH=${M2_HOME}/bin:${PATH}
RUN export MAVEN_CONFIG=$USER_HOME_DIR/.m2



ARG USER_HOME_DIR="/root"
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0



CMD ["mvn","clean","test-compile","gatling:test","-DfeatureName=userLoginApi/login.feature"]