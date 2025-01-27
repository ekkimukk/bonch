.SILENT:
all:
	cd groshi && mvn clean package && cd ..
	sudo cp ./groshi/target/groshi.war /var/tomcat/webapps/groshi.war

enter_db:
	mariadb -u expense_user -p # password
