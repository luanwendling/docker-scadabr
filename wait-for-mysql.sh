#!/bin/sh
set -e

echo "⏳ Aguardando MySQL em mysql:3306 ..."

until nc -z mysql 3306; do
  sleep 2
done

echo "✅ MySQL pronto. Iniciando Tomcat..."
exec catalina.sh run

