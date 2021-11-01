APP_NAME=hello-world
UID=$(shell id -u)

build:
	docker build -t ${APP_NAME} .

deploy:
	helm upgrade --install ${APP_NAME} ${APP_NAME}

.PHONY: build start
