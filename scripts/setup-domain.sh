#!/bin/bash

set -e

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
 echo "Usage: setup-domain.sh domain.com"
 exit 1
fi

apt update
apt install -y nginx certbot python3-certbot-nginx

sed "s/YOUR_DOMAIN/$DOMAIN/g" nginx/over.conf > /etc/nginx/sites-available/over
ln -sf /etc/nginx/sites-available/over /etc/nginx/sites-enabled/over
nginx -t
systemctl reload nginx

certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos

echo "Domain configured: https://$DOMAIN"
