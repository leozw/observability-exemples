#!/bin/bash

# Update packages and install Docker
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start

# Add the ec2-user to the docker group
sudo usermod -aG docker ec2-user

# Create the otel-config.yaml file
cat <<EOF > /home/ec2-user/otel-config.yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: "0.0.0.0:4317"
      http:
        endpoint: "0.0.0.0:4318"

exporters:
  otlphttp:
    endpoint: https://tempo.elvenobservability.com/http
    headers:
      X-Scope-OrgID: "<TENANT_ID>"
      Authorization: "Bearer <your-token>"

  prometheusremotewrite:
    endpoint: https://mimir.elvenobservability.com/api/v1/push
    headers:
      X-Scope-OrgID: "<TENANT_ID>"
      Authorization: "Bearer <your-token>"

processors:
  batch: {}
  resource:
    attributes:
    - action: insert
      key: loki.tenant
      value: host.name
  filter:
    metrics:
      exclude:
        match_type: regexp
        metric_names:
          - "go_.*"
          - "scrape_.*"
          - "otlp_.*"
          - "promhttp_.*"

service:
  pipelines:
    metrics:
      receivers: [otlp]
      processors: [batch, filter]
      exporters: [prometheusremotewrite]
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlphttp]
EOF

# Run Otel Collector Contrib using Docker
sudo docker run -d --name otel-collector-contrib \
  -p 4317:4317 -p 4318:4318 \
  -v /home/ec2-user/otel-config.yaml:/etc/otel-config.yaml:ro \
  otel/opentelemetry-collector-contrib:latest \
  --config /etc/otel-config.yaml

# Configure Docker to automatically start on boot
sudo systemctl enable docker
