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
