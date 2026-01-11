#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found: $LOG_FILE"
  exit 1
fi

echo "Unique IP addresses from Nginx logs:"
echo "-----------------------------------"

awk '{print $1}' "$LOG_FILE" | sort | uniq
