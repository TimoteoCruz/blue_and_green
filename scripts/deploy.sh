#!/bin/bash
ENV=$1
PORT=8081

if [ "$ENV" == "green" ]; then
    PORT=8082
fi

docker build -t blue-green-app:$ENV ..
docker rm -f blue-green-app-$ENV || true
docker run -d --name blue-green-app-$ENV -p $PORT:3000 blue-green-app:$ENV
