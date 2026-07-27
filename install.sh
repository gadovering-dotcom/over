#!/bin/bash
set -e

echo "Over Installer v2"

echo "Choose access method:"
echo "1) Server IP"
echo "2) Domain"
read -p "Select: " MODE

read -p "Application port [8000]: " PORT
PORT=${PORT:-8000}

if [ "$MODE" = "2" ]; then
 read -p "Domain: " DOMAIN
 echo "Domain selected: $DOMAIN"
else
 echo "Using server IP"
fi

if ! command -v docker >/dev/null 2>&1; then
 echo "Docker not found"
 exit 1
fi

if [ ! -d /opt/over ]; then
 mkdir -p /opt/over
 git clone https://github.com/gadovering-dotcom/over.git /opt/over
else
 cd /opt/over
 git pull
fi

cd /opt/over

docker compose up -d --build

chmod +x x9.sh
cp x9.sh /usr/local/bin/x9
chmod +x /usr/local/bin/x9

echo "Installation finished"
echo "Management command: x9"
