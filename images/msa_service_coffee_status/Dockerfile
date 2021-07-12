FROM openjdk:8u292-slim-buster
RUN apt-get update
RUN apt-get -y install curl
WORKDIR /app
ENV EUREKA_SERVER_IP localhost
ENV KAFKA_SERVER_IP localhost
ENV KAFKA_SERVER_PORT 9092
COPY msa-service-coffee-status-0.0.1-SNAPSHOT.jar /app/
ENTRYPOINT ["java", "-jar", "msa-service-coffee-status-0.0.1-SNAPSHOT.jar"]
