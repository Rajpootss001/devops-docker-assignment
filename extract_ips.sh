#!/bin/bash
# Extract unique client IPs from Dockerized Nginx logs

docker logs nginx 2>/dev/null | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq
