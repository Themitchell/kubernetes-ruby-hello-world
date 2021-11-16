APP_NAME=hello-world
IMAGE_NAME=themitchell/${APP_NAME}
UID=$(shell id -u)

build:
	docker build -t ${IMAGE_NAME} .

destroy:
	docker rm ${APP_NAME}

run:
	docker run -it -p 9292:9292 --name ${APP_NAME} ${IMAGE_NAME}

push: build
	docker push ${IMAGE_NAME}

minikube-start:
	minikube start

clean:
	minikube delete --purge --all

deploy:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm upgrade --install ${APP_NAME}-ingress-nginx ingress-nginx/ingress-nginx
	kubectl wait \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
	helm upgrade --install ${APP_NAME} ${APP_NAME}

fresh-deploy: clean minikube-start deploy
	minikube tunnel

.PHONY: build push deploy
