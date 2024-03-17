# docker-magister-ds
Data science tools in Python and R. RStudio and Jupyterhub are installed.

## Example usage from the image building to the container deployment.

```
$ docker build -t rstudio-jupyter-img .

$ docker run -dti -p 8000:8000 -p 8787:8787 -v $PWD/homedirs:/home --name cursoX-rstudio-jupyter rstudio-jupyter-img
```
