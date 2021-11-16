APP_NAME=hello-world
IMAGE_NAME=themitchell/${APP_NAME}
UID=$(shell id -u)
PWD=$(shell pwd)

build:
	docker build -t ${IMAGE_NAME} .

destroy:
	docker rm ${APP_NAME}

bundle:
	docker run -it --rm \
		-v "${PWD}/Gemfile.lock:/home/app/${APP_NAME}/Gemfile.lock" \
		--name ${APP_NAME} ${IMAGE_NAME} bundle install

run:
	docker run -it --rm -p 9292:9292 --name ${APP_NAME} ${IMAGE_NAME}

test:
	docker run -it --rm --name ${APP_NAME}-test ${IMAGE_NAME} bundle exec rspec

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
