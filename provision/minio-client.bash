#!/usr/bin/env bash

set -e
set -u
set -o pipefail

sudo mkdir -p /minio
sudo chown -R devops:devops /minio

wget -P /minio/ https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
cp mc /usr/local/bin/