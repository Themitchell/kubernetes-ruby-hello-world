# Equal Experts Code Test

## Dependencies

You will need the following dependencies installed on your machine:
- minkube
- kubectl
- helm

## Setup

First of all build the image

```sh
make build
```

## Pushing the app to docker hub

First login to the docker account
```sh
docker login
```

Then publish an image
```sh
make publish
```

## Deploying the app locally

Ensure you are setup to use minikube
```sh
minikube start
kubectl config use-context minikube
```

Deploy the application using helm
```sh
make deploy
```
