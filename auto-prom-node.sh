#!/bin/bash

# Nama direktori untuk project monitoring
PROJECT_DIR=~/docker-portainer

echo "📁 Membuat direktori: $PROJECT_DIR"
mkdir -p $PROJECT_DIR/prometheus
cd $PROJECT_DIR

# Membuat file docker-compose.yml
echo "📝 Membuat docker-compose.yml..."
cat <<EOF > docker-compose.yml
services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    ports:
      - "17845:9090"
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    restart: unless-stopped

  node_exporter:
    image: prom/node-exporter
    container_name: node_exporter
    ports:
      - "1322:9100"
    volumes:
      - /:/host:ro,rslave
    command:
      - '--path.rootfs=/host'
    restart: unless-stopped

  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - "3000:3000"
    volumes:
      - grafana-storage:/var/lib/grafana
    restart: unless-stopped

volumes:
  grafana-storage:
EOF

# Membuat file prometheus.yml
echo "📝 Membuat prometheus.yml..."
cat <<EOF > prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['prometheus:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['node_exporter:9100']
EOF

# Jalankan docker compose
echo "🚀 Menjalankan Docker Compose..."
docker compose up -d

echo "✅ Setup selesai. Akses:"
echo "   Prometheus → http://<ip>:17845"
echo "   Node Exporter → http://<ip>:1322"
echo "   Grafana → http://<ip>:3000"
