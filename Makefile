APP_NAME=hello-world
IMAGE_NAME=themitchell/${APP_NAME}
UID=$(shell id -u)

build:
	docker build -t ${IMAGE_NAME} .

push:
	docker push ${IMAGE_NAME}

deploy:
	helm upgrade --install ${APP_NAME} ${APP_NAME}

.PHONY: build start
