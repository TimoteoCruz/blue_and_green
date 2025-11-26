#!/bin/bash

if [ "$1" == "green" ]; then
    sed -i 's/server 127.0.0.1:8081;/server 127.0.0.1:8082;/' /etc/nginx/nginx.conf
else
    sed -i 's/server 127.0.0.1:8082;/server 127.0.0.1:8081;/' /etc/nginx/nginx.conf
fi

sudo nginx -s reload
echo "Switched to $1 environment"
