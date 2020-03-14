#!/bin/bash

LOGFILE=/var/log/update_script.log

TIMESTAMP=$(date)

exec &>>$LOGFILE

echo ""
echo "========================================="
date
echo "========================================="
echo ""

echo "> apt -y update"
apt -y update

echo ""
echo "> apt -y upgrade"
apt -y upgrade

echo ""

echo -e "Cron exec update_script.sh at: $TIMESTAMP \nLog in '/var/log/update_script.log'" | mail -s "update_script" root

