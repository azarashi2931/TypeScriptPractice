TSC_FLAGS = --strictNullChecks
CONTAINER_NAME = ts

.PHONY: build
build:
	tsc $(TSC_FLAGS)
	mkdir -p target
	mv src/*.js target/ 

.PHONY: docker_build
docker_build: build
	docker run --name $(CONTAINER_NAME) -v .:/usr/share/nginx/html:ro -d -p 8080:80 nginx

.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME)

.PHONY: run
run: build
	docker start $(CONTAINER_NAME)

.PHONY: rrun
rrun: stop run
