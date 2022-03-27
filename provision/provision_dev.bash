#!/usr/bin/env bash

set -e

DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

cp "${DIR}"/city-trees.service /etc/systemd/system/city-trees.service

sudo systemctl daemon-reload
sudo systemctl start city-trees.service
sudo systemctl enable example.service