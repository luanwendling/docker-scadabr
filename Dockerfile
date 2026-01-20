FROM tomcat:9.0-jdk11-temurin

RUN apt-get update \
 && apt-get install -y vim curl netcat-openbsd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ScadaBR /usr/local/tomcat/webapps/ScadaBR
COPY setenv.sh /usr/local/tomcat/bin/setenv.sh
COPY wait-for-mysql.sh /wait-for-mysql.sh

RUN chmod +x /usr/local/tomcat/bin/setenv.sh \
 && chmod +x /wait-for-mysql.sh

EXPOSE 8080

CMD ["/wait-for-mysql.sh"]

