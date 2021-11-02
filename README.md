# Equal Experts Code Test

## Dependencies

You will need the following dependencies installed on your machine:
- minkube
- kubectl
- helm

On a mac with homebrew run
```sh
brew install minikube kubectl helm
```

## Building the image

First of all build the image.

```sh
make build
```

Note: You will not need to build the image to run the app initially. The image is already up on dockerhub.

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

### Setting up minikube
Start minikube
```sh
minikube start
```

Set kubectl to use minikube
```sh
kubectl config use-context minikube
```

Ensure that minkube ingress is enabled
```sh
minikube addons enable ingress
```

### Deploy the app to minikube

Deploy the application using helm
```sh
make deploy
```

### Viewing the app in kubernetes
Create a tunnel to minikube
```sh
minikube tunnel
```

Navigate to the app at [http://127.0.0.1](http://127.0.0.1)
