#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# Open port for application
sudo ufw allow 2096/tcp comment 'Open port app tcp port 2096'

# Create folders for app
sudo mkdir -p /city-trees
sudo chown -R devops:devops /city-trees

# Install app systemd service
sudo cp -f ./provision/city-trees.service /etc/systemd/system/city-trees.service
sudo systemctl daemon-reload
sudo systemctl start city-trees.service
sudo systemctl enable city-trees.service