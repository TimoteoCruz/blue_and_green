#!/bin/bash

# Validar parámetro
if [ -z "$1" ]; then
  echo "Uso: ./deploy.sh <blue|green>"
  exit 1
fi

ENV=$1  # blue o green
PORT=8081

# Seleccionar puerto según ambiente
if [ "$ENV" == "green" ]; then
    PORT=8082
fi

# Ruta del proyecto (ajusta si es necesario)
APP_PATH=~/blue-green-app

# Construir imagen
echo "Construyendo imagen para $ENV..."
docker build -t blue-green-app:$ENV $APP_PATH

# Detener contenedor previo (si existe)
echo "Deteniendo contenedor previo (si existe)..."
docker rm -f blue-green-app-$ENV 2>/dev/null || true

# Ejecutar nuevo contenedor
echo "Levantando contenedor $ENV en el puerto $PORT..."
docker run -d --name blue-green-app-$ENV -p $PORT:8080 blue-green-app:$ENV

echo "✔ $ENV desplegado correctamente en el puerto $PORT"
