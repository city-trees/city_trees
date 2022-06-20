#!/bin/bash

set -e
set -u
set -o pipefail

echo "start"
# Declare backup filename
BACKUP_FILENAME=$(date -I)_city_tree_db.sql

# Perform backup
pg_dump \
  --dbname=city_trees \
  --format=c \
  --jobs=1 \
  --compress=3 \
  --verbose \
  --create \
  --file=/city_trees_backups/"$BACKUP_FILENAME"


# Remove old backups, keep only 10 most recent
ls -dt /city_trees_backups/* | tail -n +11 | xargs rm -rf