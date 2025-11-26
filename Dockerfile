FROM node:20-alpine

# Carpeta de trabajo
WORKDIR /usr/src/app

# Copiar dependencias y instalar
COPY app/package*.json ./
RUN npm install --production

# Copiar el código de la app
COPY app/ .

# Puerto del contenedor
EXPOSE 3000

# Argumento de build para diferenciar blue/green
ARG ENVIRONMENT=blue
ENV ENV=$ENVIRONMENT

# Comando para iniciar la app
CMD ["node", "server.js"]

