#!/bin/bash

# Install docker
curl -o- https://get.docker.com | bash +x

# Install docker composer
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "docker & docker-compse installed successfully"
