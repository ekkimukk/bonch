all: 
	docker build -t dudka .
	docker run --privileged --name test-container -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it dudka

