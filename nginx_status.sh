#!/bin/bash

set -e

echo "🔧 Instalando Docker..."

sudo apt-get update -y

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker

echo "🐳 Docker instalado e iniciado."

echo "🚀 Subindo nginx-prometheus-exporter..."

sudo docker run -d \
  --name nginx-exporter \
  -p 9113:9113 \
  nginx/nginx-prometheus-exporter:latest \
  -nginx.scrape-uri http://127.0.0.1/nginx_status

echo "✅ Exporter rodando na porta 9113"

if command -v ufw &> /dev/null; then
  sudo ufw allow 9113
  echo "🔓 Porta 9113 liberada no UFW"
fi

echo "✨ Pronto! Acesse http://<seu_ip>:9113/metrics para ver as métricas."
