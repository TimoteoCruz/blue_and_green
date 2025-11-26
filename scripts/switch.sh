#!/bin/bash
# Este script espera el número de puerto destino (8081 o 8082) como argumento.
PORT_TO_SWITCH=$1

UPSTREAM_CONF="/etc/nginx/upstream.conf"

# 1. Validación: Asegurar que se pasó un puerto
if [ -z "$PORT_TO_SWITCH" ]; then
    echo "🚨 ERROR: Debe especificar el puerto destino (8081 para Blue o 8082 para Green)."
    echo "Uso: ./switch.sh 8081"
    exit 1
fi

# Esto asegura que Nginx solo apunte a un puerto a la vez.
# Utilizamos 'tee' con 'sudo' para escribir en un archivo del sistema.
echo "server 127.0.0.1:$PORT_TO_SWITCH;" | sudo tee $UPSTREAM_CONF > /dev/null

# 3. Reinicio de Nginx
# Utilizamos 'restart' en lugar de 'reload' para forzar a Nginx a leer completamente
# el nuevo archivo incluido, aunque 'reload' suele ser suficiente.
sudo systemctl restart nginx

echo "✅ Tráfico conmutado exitosamente al puerto: $PORT_TO_SWITCH"

if [ "$PORT_TO_SWITCH" == "8081" ]; then
    echo "Entorno activo: BLUE"
elif [ "$PORT_TO_SWITCH" == "8082" ]; then
    echo "Entorno activo: GREEN"
fi
