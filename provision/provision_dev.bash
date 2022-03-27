#!/usr/bin/env bash

set -e

sudo cp -f ./provision/city-trees.service /etc/systemd/system/city-trees.service
sudo systemctl daemon-reload
sudo systemctl start city-trees.service
sudo systemctl enable city-trees.service

sudo apt update
sudo apt upgrade -y
sudo apt install postgresql postgresql-contrib -y
sudo systemctl start postgresql.service

