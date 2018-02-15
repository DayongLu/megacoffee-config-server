FROM openjdk:8-jdk-alpine
RUN mkdir attic-space-config-server
ADD ./target/attic-space-config-server-0.0.1-SNAPSHOT.jar attic-space-config-server
WORKDIR attic-space-config-server
EXPOSE 8888
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","attic-space-config-server-0.0.1-SNAPSHOT.jar"]