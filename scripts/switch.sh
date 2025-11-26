#!/bin/bash
ENV=$1  # blue o green

NGINX_CONF="/etc/nginx/nginx.conf"

if [ "$ENV" == "blue" ]; then
    sudo sed -i 's|proxy_pass http://green;|proxy_pass http://blue;|' $NGINX_CONF
else
    sudo sed -i 's|proxy_pass http://blue;|proxy_pass http://green;|' $NGINX_CONF
fi

sudo systemctl restart nginx

echo "Switched to $ENV environment"
