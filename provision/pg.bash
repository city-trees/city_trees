#!/usr/bin/env bash

# Install Postgres and initialize the database
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install gnupg2 wget vim -y

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y install postgresql-14

sudo -u postgres psql << EOF
  CREATE EXTENSION postgis;
  CREATE DATABASE city_trees;
  CREATE USER city_trees WITH ENCRYPTED PASSWORD 'city_trees';
  GRANT ALL PRIVILEGES ON DATABASE city_trees TO city_trees;
EOF

# Configure backup service
sudo mkdir -p /city_trees_backups
sudo chown -R postgres:postgres /city_trees_backups

sudo cp -f ./provision/pg-backup.service /etc/systemd/system/pg-backup.service
sudo systemctl daemon-reload
sudo systemctl start pg-backup.service
sudo systemctl enable pg-backup.service

sudo cp -f ./provision/pg-backup.timer /etc/systemd/system/pg-backup.timer
sudo systemctl daemon-reload
sudo systemctl start pg-backup.timer