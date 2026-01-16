#!/bin/bash
set -e

BACKUP_DIR="./backup/volumes/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
FILENAME="mysql_volume_${DATE}.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "[INFO] Parando MySQL..."
docker stop scadabr-mysql

echo "[INFO] Criando backup físico do volume..."
docker run --rm \
  -v mysql_data:/data \
  -v "$(pwd)/$BACKUP_DIR":/backup \
  alpine \
  tar czf /backup/$FILENAME /data

echo "[INFO] Iniciando MySQL..."
docker start scadabr-mysql

echo "[OK] Backup do volume criado: $BACKUP_DIR/$FILENAME"


