FROM maven:3.6.0-jdk-8-alpine


ARG COUNT
ARG SCENARIO





WORKDIR /build




COPY pom.xml .
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.1.1:go-offline


COPY src/ /build/src





CMD mvn clean test-compile gatling:test -Dgatling.simulationClass=pets.UserSimulation -DuserCount=${COUNT} -Dscenario=${SCENARIO}