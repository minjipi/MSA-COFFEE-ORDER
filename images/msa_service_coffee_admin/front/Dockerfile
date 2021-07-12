FROM tomcat:latest
ENV EUREKA_SERVER_IP localhost
COPY admin.war /usr/local/tomcat/webapps/
COPY tomcat_start.sh /usr/local/tomcat/bin/tomcat_start.sh
RUN chmod 755 /usr/local/tomcat/bin/tomcat_start.sh
EXPOSE 8080
ENTRYPOINT ["/usr/local/tomcat/bin/tomcat_start.sh"]
