# Docker Monitoring Setup (Grafana + Prometheus + Node Exporter)

Script ini akan secara otomatis membuat file konfigurasi untuk Prometheus dan Docker Compose, serta menjalankan service monitoring menggunakan Docker.

## Cara Menggunakan

```bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

git clone https://github.com/frixe-lab/docker-monitoring.git
cd docker-monitoring
chmod +x auto-prom-node.sh
./auto-prom-node.sh
```

## Port Akses

- Prometheus: http://<ip-address>:17845
- Node Exporter: http://<ip-address>:1322
- Grafana: http://<ip-address>:3000 (default login: admin / admin)
