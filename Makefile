APP_NAME=hello-world
IMAGE_NAME=themitchell/${APP_NAME}
UID=$(shell id -u)

build:
	docker build -t ${IMAGE_NAME} .

push:
	docker push ${IMAGE_NAME}

deploy:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm upgrade --install ${APP_NAME}-ingress-nginx ingress-nginx/ingress-nginx
	helm upgrade --install ${APP_NAME} ${APP_NAME}

.PHONY: build push deploy
