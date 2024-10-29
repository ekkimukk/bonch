sources = $(wildcard *.java)
exec = $(basename $(sources))

.SILENT:
all: main

main:
	javac $(sources)
	java $(exec)
	#rm -rf $(exec).class
