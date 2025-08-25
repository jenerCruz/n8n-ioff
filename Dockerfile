# usar la inagen oficial de Node.js en su version alpine
FROM node:lts-alpine

# pasar N8N_VERSION como argumento durante la construccion, o usar la version por defecto
ARG N8N_VERSION=1.39.1

# Actualizar los paquetes e instalar las sependencias necesarias 
RUN apk add --update graphicsmagick tzdata

# establecer usuario como root para evitar que n8n se ejecute como root mas adelante
USER root

# Instalar n8n junto con kas dependencias temporales 
# necesarias para compliar correctamente el proyecto
RUN apk --update add --virtual build-dependencies python3 build-base && \
	npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
	apk del build-dependencies

# estableber el directorio de trabajo
WORKDIR /data

	# definir el comando por defecto al iniciar el contenedor 
CMD ["n8n"]
