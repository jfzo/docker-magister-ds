# docker-magister-ds
Data science tools in Python and R. RStudio and Jupyterhub are installed.

## Example usage from the image building to the container deployment.

```
$ docker build -t rstudio-jupyter-01 -f Dockerfile

$ docker run -dti -p 8000:8000 -p 8888:8888 -p 8787:8787 -v $PWD/homedirs:/home --name mag-rstudio-jupyter rstudio-jupyter-01
```
