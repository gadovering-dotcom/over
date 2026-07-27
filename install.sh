#!/bin/bash
set -e

echo "Installing Over Daily Routine..."

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found. Install Docker first."
  exit 1
fi

mkdir -p /opt/over
cd /opt/over

git clone https://github.com/gadovering-dotcom/over.git . 2>/dev/null || git pull

echo "Over installation base completed."
