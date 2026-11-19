# Actividad 9: Docker Compose - Aplicación Angular con Nginx

## Integrantes del Equipo (Los Técnicos)
- Edgar Reyes de la Cruz
- Fátima Estefanía González Lozano
- Kenia Isamara Andrade Cedillo
- Ramiro Alejandro Alfaro Alanís
- Miguel Fuentes Hernández

## Descripción
Este proyecto levanta un contenedor mediante Docker Compose que:
1. Clona el repositorio público del equipo (`https://github.com/Pyedgar/Repo_Tecnicos.git`).
2. Compila la aplicación Angular ubicada en `proyecto-tecnicos`.
3. Sirve el resultado compilado utilizando **Nginx** en el puerto `8080`.

## Estructura del Proyecto
```text
/mi-practica-docker/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
└── README.md
```

## Comandos utilizados
1. Construir y levantar el contenedor:
   ```bash
   docker compose up -d --build
   ```
2. Exportar la imagen generada:
   ```bash
   docker save -o mi-angular-nginx.tar mi-angular-nginx:latest
   ```
