#!/bin/bash
set -e

BACKUP_DIR="./backup/mysql/dumps"
DATE=$(date +%Y%m%d_%H%M%S)
FILENAME="scadabr_${DATE}.sql"

MYSQL_USER="scadabr"
MYSQL_PASSWORD="scadabr"
MYSQL_DB="scadabr"

mkdir -p "$BACKUP_DIR"

echo "[INFO] Criando backup lógico do MySQL..."

docker exec scadabr-mysql \
  sh -c "mysqldump \
  --single-transaction \
  --routines \
  --triggers \
  --no-tablespaces \
  -u${MYSQL_USER} \
  -p${MYSQL_PASSWORD} \
  ${MYSQL_DB}" \
  > "$BACKUP_DIR/$FILENAME"

echo "[OK] Backup criado: $BACKUP_DIR/$FILENAME"

