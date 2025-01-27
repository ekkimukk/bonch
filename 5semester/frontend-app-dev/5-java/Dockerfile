FROM tomcat:9.0.1-jre8-alpine
# ADD ./groshi /usr/local/tomcat/webapps/groshi
ADD ./groshi/target/groshi-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/
RUN echo '<user username="tomcat" password="tomcat" roles="tomcat,manager-gui,admin-gui"/>' >> /usr/local/tomcat/conf/tomcat-users.xml
CMD ["catalina.sh", "run"]

