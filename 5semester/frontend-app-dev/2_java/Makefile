sources = $(wildcard *.java)
exec = $(basename $(sources))

.SILENT:
all: main

main:
	javac $(sources)
	java $(exec)

clean:
	rm -rf *.class
