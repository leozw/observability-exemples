#!/bin/bash

# Update packages and install Docker
sudo apt-get update -y
sudo apt-get install docker.io -y

# Add the ubuntu user to the docker group
sudo usermod -aG docker $USER

# Run Otel Collector Contrib using Docker
sudo docker run -d --name otel-collector-contrib \
  -p 4317:4317 -p 4318:4318 \
  -v /home/ubuntu/otel-config.yaml:/etc/otel-config.yaml:ro \
  otel/opentelemetry-collector-contrib:latest \
  --config /etc/otel-config.yaml

# Configure Docker to automatically start on boot
sudo systemctl enable docker
