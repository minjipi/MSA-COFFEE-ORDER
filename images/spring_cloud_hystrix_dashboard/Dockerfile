FROM openjdk:11-jre-slim-buster
RUN apt-get update
RUN apt-get -y install curl
WORKDIR /app
ENV CONFIG_SERVER_IP localhost
ENV EUREKA_SERVER_IP localhost
COPY msa-architecture-hystrix-dashboard-master-0.0.1-SNAPSHOT.jar /app/
ENTRYPOINT ["java", "-jar", "msa-architecture-hystrix-dashboard-master-0.0.1-SNAPSHOT.jar"]
