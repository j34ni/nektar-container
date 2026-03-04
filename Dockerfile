FROM ubuntu:22.04

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates tzdata wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q -nc --no-check-certificate -P /var/tmp https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh && \
    bash /var/tmp/Miniforge3-Linux-x86_64.sh -b -p /opt/conda && \
    rm /var/tmp/Miniforge3-Linux-x86_64.sh

ENV TZ="Europe/Oslo"
ENV PATH="/opt/conda/bin:$PATH"

RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba install -y -c conda-forge nektar=5.9.0 micro mvapich=4.1 vim && \
    conda clean -afy

COPY start.sh /opt/
