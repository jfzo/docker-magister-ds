# docker-magister-ds
Imagen docker para Data science en Python y R, que permite el acceso WEB vía  Jupyterhub y RStudio.

# Instrucciones

1. Crear una cuenta para el usuario U, reemplazando *U* por el nombre de usuario.

```adduser U```

2. Agregar usuario al grupo que corresponda, esto es  magister-alumnx o pregrado-alumnx. 

```
usermod -a -G pregrado-alumnx U
```

3. Se usa plantilla de imagen docker para crear contenedor de usuario. **Dentro** de directorio `docker-magister-ds`, modificar `nuevos_usuarios.txt` , agregando al usuario, su UID, su GID y la contraseña que se usará para Jupyter y RStudio.

4. **Dentro** del directorio, ejecutar el siguiente comando, reemplazando *U* por el nombre de usuario. Esto tardará alrededor de un minuto.

```
docker build -t rstudio-jupyter-U .
```

5. Identificar qué par de puertos se usará para Jupyter y RStudio-Web. Por ejemplo, X e Y respectivamente. 

6. Lanzar el contenedor mediante el comando indicado a continuación, reemplazando *X*, *Y* y *U* por los puertos ya identificados y el nombre de usuario.

```
docker run -dti -p X:8000 -p Y:8787 -v /home/U/docker-homedir:/home rstudio-jupyter-U
```





