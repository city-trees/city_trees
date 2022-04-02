#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# Install app systemd service
sudo cp -f ./provision/city-trees.service /etc/systemd/system/city-trees.service
sudo systemctl daemon-reload
sudo systemctl start city-trees.service
sudo systemctl enable city-trees.service

# Install Postgres and initialize the database
sudo apt update
sudo apt upgrade -y
sudo apt install gnupg2 wget vim -y

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt -y update
sudo apt -y install postgresql-14

sudo -u postgres psql << EOF
  CREATE DATABASE city_trees;
  CREATE USER city_trees WITH ENCRYPTED PASSWORD 'city_trees';
  GRANT ALL PRIVILEGES ON DATABASE city_trees TO city_trees;
EOF

# Configure backup service
sudo cp -f ./provision/pg-backup.bash /opt/pg-backup.bash

sudo cp -f ./provision/pg-backup.service /etc/systemd/system/pg-backup.service
sudo systemctl start pg-backup.service
sudo systemctl enable pg-backup.service

sudo cp -f ./provision/pg-backup.timer /etc/systemd/system/pg-backup.timer
sudo systemctl start pg-backup.timer
sudo systemctl enable pg-backup.timer

sudo systemctl daemon-reload