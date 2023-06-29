FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel

# Arguments to build Docker Image using CUDA
ARG USE_CUDA=0
ARG TORCH_ARCH=

ENV AM_I_DOCKER True
ENV BUILD_WITH_CUDA "${USE_CUDA}"
ENV TORCH_CUDA_ARCH_LIST "${TORCH_ARCH}"
ENV CUDA_HOME /usr/local/cuda-11.6/

RUN apt-get update && apt-get install --no-install-recommends wget unzip ffmpeg=7:* \
    libsm6=2:* libxext6=2:* git=1:* nano=2.* \
    vim=2:* -y \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# Install build-essential
RUN apt-get update && apt-get install -y build-essential

WORKDIR /home/appuser

# Install tokenizers before transformers
RUN python -m pip install --no-cache-dir tokenizers

RUN python -m pip install --no-cache-dir fastapi==0.65.2 uvicorn==0.15.0 \
    werkzeug==2.0.1 regex==2021.4.4 torch==2.0.1 pyngrok==5.0.5 \
    timm==0.4.12 transformers==4.15.0 fairscale==0.4.4 \
    pycocoevalcap torch torchvision Pillow scipy \
    git+https://github.com/openai/CLIP.git numpy \
    opencv-python-headless
