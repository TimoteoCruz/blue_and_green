#!/bin/bash

# ================================
# Parámetros
# ================================
ENV=$1      # blue | green
TAG=$2      # hash dinámico del pipeline (ej: 6a25ace...)
IMAGE="***/blue-green-app:$TAG"

# Validaciones
if [ -z "$ENV" ] || [ -z "$TAG" ]; then
  echo "Uso: ./deploy.sh <blue|green> <tag>"
  exit 1
fi

if [ "$ENV" != "blue" ] && [ "$ENV" != "green" ]; then
  echo "Error: ENV debe ser blue o green"
  exit 1
fi

# Puerto según ambiente
PORT=8081
if [ "$ENV" == "green" ]; then
    PORT=8082
fi

echo "============================"
echo "🚀 Deploying $ENV"
echo "🔖 TAG: $TAG"
echo "🐳 Image: $IMAGE"
echo "🌐 Port: $PORT"
echo "============================"

# ================================
# Pull de imagen
# ================================
echo "📥 Pulling image..."
docker pull $IMAGE

# ================================
# Detener contenedor previo
# ================================
echo "🧹 Removing old container..."
docker rm -f blue-green-app-$ENV 2>/dev/null || true

# ================================
# Ejecutar nuevo contenedor
# ================================
echo "🐳 Starting container..."
docker run -d --name blue-green-app-$ENV -p $PORT:8080 $IMAGE

echo "✅ $ENV environment deployed on port $PORT using TAG $TAG"
