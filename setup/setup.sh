#!/bin/bash

echo "Installing go..."
sudo wget https://golang.org/dl/go1.17.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.17.8.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin
source ~/.bashrc
export GO111MODULE=on

echo "Checking go version..."
go version

echo "Installing protobuf compiler..."
PB_REL="https://github.com/protocolbuffers/protobuf/releases"
curl -LO $PB_REL/download/v3.15.8/protoc-3.15.8-linux-x86_64.zip

sudo apt-get install unzip
unzip protoc-3.15.8-linux-x86_64.zip -d $HOME/.local
export PATH="$PATH:$HOME/.local/bin"
source ~/.bashrc

echo "Installing gRPC..."
go get google.golang.org/grpc

echo "Installing docker..."
sudo apt-get update
sudo apt-get install -y docker.io

echo "Docker version..."
sudo docker -v

echo "Installing minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "Kubectl version..."
kubectl version --client

echo "Setting up Docker..."
sudo docker ps -a
sudo docker images -a
sudo docker run -it --rm --name mongodb_container -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=admin -v mongodata:/data/db -d -p 27017:27017 mongo:4.4.3

echo "Installing mgo.v2 pkg..."
go get gopkg.in/mgo.v2

echo "Installing godotenv pkg..."
go get github.com/joho/godotenv

echo "Setup finished."
echo "Happy Coding!"
