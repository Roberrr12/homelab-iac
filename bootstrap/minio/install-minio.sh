#!/bin/bash
set -euo pipefail

# Debe ejecutarse como root
if [ "$EUID" -ne 0 ]; then
    echo "Ejecuta como root."
    exit 1
fi

echo "Instalando dependencias"
apt update
apt install -y golang-go

echo "Instalando MinIO"
export GOPATH="${GOPATH:-/root/go}"

go install github.com/minio/minio@latest
install -m 0755 "$(go env GOPATH)/bin/minio" /usr/local/bin/minio

echo "Creando usuario MinIO"
if ! id minio-user >/dev/null 2>&1; then
    useradd -r -s /usr/sbin/nologin minio-user
fi

echo "Creando directorio de datos"
mkdir -p /data/minio
chown -R minio-user:minio-user /data/minio

echo "Creando servicio systemd"

cat > /etc/systemd/system/minio.service << 'EOF'
[Unit]
Description=MinIO Object Storage
After=network-online.target
Wants=network-online.target

[Service]
User=minio-user
Group=minio-user
WorkingDirectory=/data/minio

Environment=MINIO_ROOT_USER=CAMBIAR
Environment=MINIO_ROOT_PASSWORD=CAMBIAR

ExecStart=/usr/local/bin/minio server \
    --address :9000 \
    --console-address :9001 \
    /data/minio

Restart=always
RestartSec=5
LimitNOFILE=65536
TimeoutStopSec=infinity
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
EOF

echo "Arrancando MinIO"
systemctl daemon-reload
systemctl enable --now minio

echo "Comprobando servicio"
systemctl --no-pager --full status minio

echo
echo "MinIO instalado."
echo "API:     http://$(hostname -I | awk '{print $1}'):9000"
echo "Console: http://$(hostname -I | awk '{print $1}'):9001"