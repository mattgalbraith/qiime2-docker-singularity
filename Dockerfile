################# BASE IMAGE ######################
FROM --platform=linux/amd64 mambaorg/micromamba:1.3.1-focal
# Micromamba for fast building of small conda-based containers.
# https://github.com/mamba-org/micromamba-docker
# The 'base' conda environment is automatically activated when the image is running.

################## METADATA ######################
LABEL base_image="mambaorg/micromamba:1.3.1-focal"
LABEL version="2024.2"
LABEL software="Qiime2"
LABEL software.version=""
LABEL about.summary="QIIME 2 is a powerful, extensible, and decentralized microbiome analysis package with a focus on data and analysis transparency."
LABEL about.home="https://qiime2.org/"
LABEL about.documentation="https://docs.qiime2.org/2024.2/"
LABEL about.license_file="https://github.com/qiime2/qiime2/blob/dev/LICENSE"
LABEL about.license="BSD 3-Clause License"

################## MAINTAINER ######################
MAINTAINER Matthew Galbraith <matthew.galbraith@cuanschutz.edu>

################## INSTALLATION ######################

# Copy the yaml file to your docker image and pass it to micromamba
COPY --chown=$MAMBA_USER:$MAMBA_USER qiime2-amplicon-2024.2-py38-linux-conda.yml /tmp/qiime2-amplicon-2024.2-py38-linux-conda.yml
RUN micromamba install -y -n base -f /tmp/qiime2-amplicon-2024.2-py38-linux-conda.yml && \
    micromamba clean --all --yes

