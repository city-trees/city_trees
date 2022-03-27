#!/usr/bin/env bash

DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

cp "${DIR}"/city-trees.service /etc/systemd/system/city-trees.service

systemctl daemon-reload
systemctl start city-trees.service
systemctl enable example.service