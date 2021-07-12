FROM openjdk:8u292-slim-buster
RUN apt-get update
RUN apt-get -y install curl
WORKDIR /app
ENV CONFIG_SERVER_IP localhost
ENV EUREKA_SERVER_IP localhost
COPY msa-architecture-server-zuul-0.0.1-SNAPSHOT.jar /app/
ENTRYPOINT ["java", "-jar", "msa-architecture-server-zuul-0.0.1-SNAPSHOT.jar"]
