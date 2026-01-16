FROM tomcat:9.0-jdk11-temurin

RUN apt-get update \
 && apt-get install -y vim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/local/tomcat/webapps/*

COPY ScadaBR /usr/local/tomcat/webapps/ScadaBR

COPY setenv.sh /usr/local/tomcat/bin/setenv.sh
RUN chmod +x /usr/local/tomcat/bin/setenv.sh

EXPOSE 8080
CMD ["catalina.sh", "run"]

