FROM alpine:3.9

LABEL maintainer="Nicolas Karolak <nicolas.karolak@ubicast.eu>"

RUN \
    apk add \
        ansible \
        bash \
        gcc \
        git \
        make \
        libc-dev \
        libffi-dev \
        openssh-client \
        openssl-dev \
        python3 \
        python3-dev \
        terraform \
        unzip \
        wget \
    && \
    python3 -m pip install --upgrade pip

ENV PACKER_VERSION=1.4.1
ENV PACKER_URL=https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
RUN \
    wget -O /tmp/packer.zip ${PACKER_URL} && \
    unzip /tmp/packer.zip -d /usr/local/bin

