#!/bin/bash

# Check root
if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# Install Docker
snap install docker

# Install Docker Compose
apt install curl

ARCH=$(uname -m) && [[ "${ARCH}" == "armv7l" ]] && ARCH="armv7"
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-${ARCH}" -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Verify the installation
docker -v
docker-compose version


