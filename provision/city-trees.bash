#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# Open port for application
sudo ufw allow 443/tcp comment 'Open port app tcp port 443'
sudo ufw allow 80/tcp comment 'Open port app tcp port 80'

# Create folders for app
sudo mkdir -p /city_trees
sudo chown -R devops:devops /city_trees

# TODO move into secrets
cp ./provision/citytrees.cert /city_trees/citytrees.cert
cp ./provision/citytrees.key /city_trees/citytrees.key

# Install app systemd service
sudo cp -f ./provision/city-trees.service /etc/systemd/system/city-trees.service
sudo systemctl daemon-reload

# First time it might faile without deploy
sudo systemctl enable city-trees.service || true
sudo systemctl start city-trees.service || true