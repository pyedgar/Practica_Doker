# ==========================================
# ETAPA 1: Clonar y compilar la app Angular
# ==========================================
FROM node:20-alpine AS builder

# Instalar git para clonar el repositorio
RUN apk add --no-cache git

WORKDIR /repo

# URL del repositorio público donde está el proyecto de Angular del equipo
ARG REPO_URL=https://github.com/Pyedgar/Repo_Tecnicos.git

# Clonar el repositorio
RUN git clone ${REPO_URL} .

# Entrar a la carpeta del proyecto Angular
WORKDIR /repo/proyecto-tecnicos

# Instalar dependencias y compilar Angular
RUN npm install
RUN npm run build -- --configuration=production

# Copiar los archivos compilados a /app/build-output
RUN mkdir -p /app/build-output && \
    if [ -d "$(find dist -mindepth 2 -maxdepth 2 -type d -name 'browser' | head -n 1)" ]; then \
        cp -r $(find dist -mindepth 2 -maxdepth 2 -type d -name 'browser' | head -n 1)/* /app/build-output/; \
    else \
        cp -r $(find dist -mindepth 1 -maxdepth 1 -type d | head -n 1)/* /app/build-output/; \
    fi

# ==========================================
# ETAPA 2: Servir con Nginx
# ==========================================
FROM nginx:alpine

# Limpiar archivos por defecto de nginx
RUN rm -rf /usr/share/nginx/html/*

# Copiar los archivos compilados desde la Etapa 1
COPY --from=builder /app/build-output/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
