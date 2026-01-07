FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y build-essential && apt-get install -y git

COPY docker_env.yml /tmp/env.yaml

RUN conda env create -n hstaxe_env -f /tmp/env.yaml
RUN rm -rf /opt/conda/pkgs/*
RUN echo "source activate hstaxe_env" > ~/.bashrc
ENV PATH /opt/conda/envs/hstaxe_env/bin:$PATH
