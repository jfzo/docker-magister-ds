#FROM ubuntu:20.04

FROM rocker/rstudio 

#ENV DEBIAN_FRONTEND noninteractive
ENV NCPUS=5

#Note: This layer is needed to get PYTHON PIP and PYTHON SETUPTOOLS upgraded. For some reason this can't be combined and it causes and error when using pip3.
RUN mkdir -p /workdir && chmod 777 /workdir && \
    apt-get update -yqq && \ 
    apt-get install -yqq --no-install-recommends sudo curl git wget tzdata libjpeg-dev bzip2 libzmq3-dev && \
    apt-get install -yqq python3 python3-pip && \
    apt-get install -yqq lib32ncurses6 && \
    apt-get install -yqq npm && \
    pip3 --no-cache-dir install --upgrade pip setuptools 

RUN  pip install jupyter -U && pip install jupyterlab && pip install jupyterhub

RUN npm install -g configurable-http-proxy


ADD settings/jupyter_notebook_config.py /etc/jupyter/
ADD settings/jupyterhub_config.py /etc/jupyterhub/
ADD StartHere.ipynb /etc/skel
COPY scripts /scripts
#COPY createusers.txt /root/
COPY nuevos_usuarios.txt /root/createusers.txt

RUN chmod -R 755 /scripts && \
    jupyter trust /etc/skel/StartHere.ipynb
    
ENV S6_VERSION=v2.1.0.2
ENV RSTUDIO_VERSION=2023.12.0+369
ENV DEFAULT_USER=rstudio
ENV PANDOC_VERSION=default
ENV QUARTO_VERSION=default

RUN /scripts/install_rstudio.sh
RUN /scripts/install_pandoc.sh
RUN /scripts/install_quarto.sh


RUN /scripts/install2.r --error --skipinstalled -n "$NCPUS" remotes
RUN R --quiet -e 'remotes::install_github("IRkernel/IRkernel@*release")'
RUN R --quiet -e 'IRkernel::installspec(user = FALSE)'

EXPOSE 8000
EXPOSE 8787
EXPOSE 8888

#ENTRYPOINT ["jupyter" , "lab","--ip=0.0.0.0","--allow-root"]
#ENTRYPOINT ["jupyter-labhub"] 
#ENTRYPOINT ["jupyterhub"] 

#CMD "/scripts/sys/init.sh"
# define entrypoint command
CMD ["/bin/bash", "/scripts/sys/init.sh"]
