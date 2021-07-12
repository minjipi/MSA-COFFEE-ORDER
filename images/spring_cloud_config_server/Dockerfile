FROM openjdk:8u292-slim-buster
RUN apt-get update
RUN apt-get -y install curl
WORKDIR /app
COPY msa-architecture-server-config-0.0.1-SNAPSHOT.jar /app/
ENTRYPOINT ["java", "-jar", "msa-architecture-server-config-0.0.1-SNAPSHOT.jar"]
