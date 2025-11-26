#!/bin/bash
ENV=$1  # blue o green
PORT=8081

if [ "$ENV" == "green" ]; then
    PORT=8082
fi

# Construir imagen
docker build -t blue-green-app:$ENV ~/blue-green-app

# Detener contenedor si existe
docker rm -f blue-green-app-$ENV 2>/dev/null || true

# Correr contenedor
docker run -d --name blue-green-app-$ENV -p $PORT:8080 blue-green-app:$ENV

echo "$ENV environment deployed on port $PORT"

