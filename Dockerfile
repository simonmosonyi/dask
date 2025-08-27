FROM mambaorg/micromamba:1.5.8
WORKDIR /usr/local/app

COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml /tmp/environment.yml
RUN micromamba env create -y -f /tmp/environment.yml && micromamba clean -a -y

ENV MAMBA_DOCKERFILE_ACTIVATE=1
SHELL ["/bin/bash", "-lc"]
ENV PATH=/opt/conda/envs/flood/bin:$PATH