FROM maven:3.6.0-jdk-8-alpine

ARG COUNT
ARG SCENARIO
ARG BUCKET


RUN apk add --no-cache \
  python \
  py-pip \
  && \
  pip install awscli

WORKDIR /build

COPY pom.xml .


RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.1.1:go-offline

COPY src/ /build/src


CMD mvn clean test-compile gatling:test -Dgatling.simulationClass=pets.UserSimulation -DuserCount=${COUNT} -Dscenario=${SCENARIO} ; cd target ; export DATE=$(date "+%Y-%m-%d-%H:%M:%S:%s") ; mv karate.log karate-${DATE}.log ; ls ; aws s3 cp *.log s3://${BUCKET}/karate-logs/ ; cd gatling/usersimulation-* ;  mv simulation.log simulation-${DATE}.log ; ls ; aws s3 cp *.log s3://${BUCKET}/logs/
