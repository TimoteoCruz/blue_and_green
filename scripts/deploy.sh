#!/bin/bash

# Parámetros recibidos desde GitHub Actions
ENV=$1                 # blue o green
SHA=$2                 # hash del commit
REGISTRY_URL=$3        # ejemplo: timoteocruz31/blue-green-app

# Puerto dinámico según entorno
if [ "$ENV" == "green" ]; then
    PORT=8082
else
    PORT=8081
fi

# Tag completo a ejecutar
IMAGE_TAG="${REGISTRY_URL}:${SHA}"

echo "============================"
echo "🚀 Deploying environment: $ENV"
echo "🔖 Using image: $IMAGE_TAG"
echo "🌐 Port: $PORT"
echo "============================"

# Obtener imagen desde Docker Hub
echo "📥 Pulling image..."
docker pull $IMAGE_TAG

# Detener contenedor previo (si existe)
echo "🧹 Removing old container (if exists)..."
docker rm -f blue-green-app-$ENV 2>/dev/null || true

# Ejecutar el nuevo contenedor
echo "🐳 Starting new container..."
docker run -d \
  --name blue-green-app-$ENV \
  -p $PORT:8080 \
  $IMAGE_TAG

echo "✅ $ENV environment deployed on port $PORT"
