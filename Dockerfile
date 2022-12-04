FROM eclipse-temurin:11-jdk-alpine
#FROM adoptopenjdk/openjdk11:alpine-jre

LABEL maintainer="MageEdu <mage@magedu.com>"

ADD target/spring-boot-helloworld-*-SNAPSHOT.jar /applications/spring-boot-helloworld.jar

ENTRYPOINT ["/bin/sh","-c","/opt/java/openjdk/bin/java -jar /applications/spring-boot-helloworld.jar --server.port=80"]
