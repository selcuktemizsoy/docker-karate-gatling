FROM maven:3.6.0-jdk-8-alpine

ARG COUNT
ARG SCENARIO
ARG BUCKET


RUN apk add --no-cache \
  python \
  git \
  py-pip \
  openssh-client \
  && \
  pip install awscli

#ENV AWS_PROFILE=digiturk-playground AWS_SDK_LOAD_CONFIG=1
RUN mkdir -p /root/.ssh
COPY ./.ssh/id_rsa_shared /root/.ssh/id_rsa
COPY ./.ssh/config /root/.ssh/config

RUN git clone git@github.com:selcuktemizsoy/docker-karate-gatling.git

WORKDIR ./docker-karate-gatling

RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.1.1:go-offline

CMD mvn clean test-compile gatling:test -Dgatling.simulationClass=pets.UserSimulation -DuserCount=${COUNT} -Dscenario=${SCENARIO} ; cd target ; export DATE=$(date "+%Y-%m-%d-%H:%M:%S:%s") ; mv karate.log karate-${DATE}.log ; ls ; aws s3 cp *.log s3://${BUCKET}/karate-logs/ ; cd gatling/usersimulation-* ;  mv simulation.log simulation-${DATE}.log ; ls ; aws s3 cp *.log s3://${BUCKET}/logs/
