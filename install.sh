#!/bin/bash
set -e

echo "Installing Over Daily Routine..."

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found. Please install Docker first."
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

echo "Over is running."
