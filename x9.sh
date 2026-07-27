#!/bin/bash

APP_DIR=/opt/over

while true; do
clear
echo "===================="
echo "   Over Manager x9"
echo "===================="
echo "1) Restart Website"
echo "2) Update Website"
echo "3) View Logs"
echo "4) Backup Database"
echo "5) Rebuild Docker"
echo "6) Exit"
echo ""
read -p "Select: " choice

case $choice in
1)
 cd $APP_DIR && docker compose restart
 echo "Restart completed"
 ;;
2)
 cd $APP_DIR && git pull && docker compose up -d --build
 echo "Update completed"
 ;;
3)
 cd $APP_DIR && docker compose logs --tail=100
 ;;
4)
 mkdir -p $APP_DIR/backups
 cp $APP_DIR/app/routine.db $APP_DIR/backups/routine-$(date +%F).db 2>/dev/null
 echo "Backup completed"
 ;;
5)
 cd $APP_DIR && docker compose up -d --build --force-recreate
 ;;
6) exit ;;
esac

read -p "Press Enter..."
done
