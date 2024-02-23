[![Docker Image CI](https://github.com/mattgalbraith/qiime2-docker-singularity/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mattgalbraith/qiime2-docker-singularity/actions/workflows/docker-image.yml)

# qiime2-docker-singularity

## Build Docker container for qiime2 and (optionally) convert to Apptainer/Singularity.  

QIIME 2 is a powerful, extensible, and decentralized microbiome analysis package with a focus on data and analysis transparency.  
https://qiime2.org/ 
  
#### Requirements:
see https://docs.qiime2.org/2024.2/  
Install within image using micromamba
https://github.com/mamba-org/micromamba-docker
  
## Build docker container:  

### 1. For QIIME 2 installation instructions:  
https://docs.qiime2.org/2024.2/install/native/#miniconda  


### 2. Build the Docker Image

#### To build image from the command line:  
``` bash
# Assumes current working directory is the top-level <tool>-docker-singularity directory
docker build -t qiime2:2024.2 . # tag should match software version
```
* Can do this on [Google shell](https://shell.cloud.google.com)

#### To test this tool from the command line:
``` bash
docker run --rm -it qiime2:2024.2 qiime --help 
```

## Optional: Conversion of Docker image to Singularity  

### 3. Build a Docker image to run Singularity  
(skip if this image is already on your system)  
https://github.com/mattgalbraith/singularity-docker

### 4. Save Docker image as tar and convert to sif (using singularity run from Docker container)  
``` bash
docker images
docker save <Image_ID> -o qiime2_2024.2-docker.tar && gzip qiime2_2024.2-docker.tar # = IMAGE_ID of <tool> image
docker run -v "$PWD":/data --rm -it singularity:1.1.5 bash -c "singularity build /data/qiime2_2024.2.sif docker-archive:///data/qiime2_2024.2-docker.tar.gz"
```
NB: On Apple M1/M2 machines ensure Singularity image is built with x86_64 architecture or sif may get built with arm64  

Next, transfer the <tool>.sif file to the system on which you want to run <tool> from the Singularity container  

### 5. Test singularity container on (HPC) system with Singularity/Apptainer available  
``` bash
# set up path to the Singularity container
TOOL_SIF=path/to/qiime2_2024.2.sif

# Test that <tool> can run from Singularity container
singularity run $TOOL_SIF qiime --help # depending on system/version, singularity may be called apptainer
```