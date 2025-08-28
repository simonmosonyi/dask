ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_IMAGE=$REGISTRY/$OWNER/base-notebook
FROM $BASE_IMAGE

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    curl git nano-tiny vim-tiny less && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


USER ${NB_UID}

COPY --chown=${NB_UID}:${NB_GID} environment.yaml /tmp/environment.yaml
RUN mamba env update -n base -f /tmp/environment.yaml && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

ENV PATH=/opt/conda/envs/flood/bin:$PATH
