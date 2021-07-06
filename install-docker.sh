#!/bin/bash
sudo -y apt-get update
sudo -y apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo -y apt-get update
sudo -y apt-get install docker-ce docker-ce-cli containerd.io

gcloud auth login
sudo usermod -a -G docker ${USER}

VERSION=2.0.0
OS=linux
ARCH=amd64
curl -fsSL "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz"   | tar xz --to-stdout ./docker-credential-gcr   | sudo tee /usr/bin/docker-credential-gcr > /dev/null && sudo chmod +x /usr/bin/docker-credential-gcr

docker-credential-gcr configure-docker


