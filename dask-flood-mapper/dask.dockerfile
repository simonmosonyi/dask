FROM continuumio/miniconda3:23.11.1-0

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    curl git nano-tiny vim-tiny less && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY environment.yaml /tmp/environment.yaml

RUN conda install -n base mamba -c conda-forge && \
    mamba env update -n base -f /tmp/environment.yaml && \
    conda clean -afy

SHELL ["conda", "run", "-n", "dask", "/bin/bash", "-c"]

CMD ["dask-worker"]
