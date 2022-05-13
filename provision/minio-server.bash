#!/usr/bin/env bash

set -e
set -u
set -o pipefail

sudo mkdir -p /minio
sudo chown -R devops:devops /minio

wget -P /minio/ https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
cp minio /usr/local/bin/

sudo cp -f ./provision/minio.service /etc/systemd/system/minio.service
sudo systemctl daemon-reload
sudo systemctl start minio.service
sudo systemctl enable minio.service
