APP_NAME=hello-world
UID=$(shell id -u)

build:
	docker build -t ${APP_NAME} .

start:
	docker run -it -p 9292:9292 --name ${APP_NAME} ${APP_NAME}

.PHONY: build start
