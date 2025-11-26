#!/bin/bash
ENV=$1  # blue o green

# Actualizar Nginx con sudo
NGINX_CONF="/etc/nginx/nginx.conf"

# Reemplazar el puerto del backend según el entorno
if [ "$ENV" == "blue" ]; then
    sudo sed -i 's/set \$backend_port .*;/set \$backend_port 8081;/' $NGINX_CONF
else
    sudo sed -i 's/set \$backend_port .*;/set \$backend_port 8082;/' $NGINX_CONF
fi

# Reiniciar Nginx
sudo systemctl restart nginx

echo "Switched to $ENV environment"

