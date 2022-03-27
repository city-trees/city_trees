#!/usr/bin/env bash

set -e

sudo cp -f ./provision/city-trees.service /etc/systemd/system/city-trees.service
sudo systemctl daemon-reload
sudo systemctl start city-trees.service
sudo systemctl enable city-trees.service