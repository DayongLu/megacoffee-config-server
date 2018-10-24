FROM openjdk:8-jdk-alpine
RUN mkdir as-config-server
RUN chmod 777 as-config-server
RUN adduser -S app
USER app

COPY ./target/attic-space-config-server-0.0.1-SNAPSHOT.jar as-config-server/as-config-server.jar
WORKDIR as-config-server
EXPOSE 8888
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","as-config-server.jar"]