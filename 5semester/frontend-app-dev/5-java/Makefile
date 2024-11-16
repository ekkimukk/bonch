sources = Main.java
exec = Main
path = /var/www/mysite.com

.SILENT:
all: main

main:
	javac $(sources)
	# cp * $(path)/
	java $(exec)
	rm -rf *.class

clean:
	rm -rf $(path)/*.class *.class
