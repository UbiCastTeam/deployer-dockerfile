# BUILDER

FROM alpine:latest AS builder

LABEL maintainer="Nicolas Karolak <nicolas.karolak@ubicast.eu>"

ENV VENV /usr/local/pyvenv
ENV PATH ${VENV}/bin:${PATH}

RUN \
    apk add \
        gcc \
        libc-dev \
        libffi-dev \
        openssl-dev \
        python3-dev \
        unzip \
        wget \
    && \
    python3 -m venv ${VENV} && \
    pip install --upgrade pip wheel


ENV TERRAFORM_VERSION 0.12.2
ENV TERRAFORM_URL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN \
    wget -O /tmp/terraform.zip ${TERRAFORM_URL} && \
    unzip /tmp/terraform.zip -d /usr/local/bin

ENV PACKER_VERSION 1.4.1
ENV PACKER_URL https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
RUN \
    wget -O /tmp/packer.zip ${PACKER_URL} && \
    unzip /tmp/packer.zip -d /usr/local/bin

ENV ANSIBLE_VERSION 2.8.1
RUN pip install ansible==${ANSIBLE_VERSION}

# IMAGE

FROM alpine:latest

LABEL maintainer="Nicolas Karolak <nicolas.karolak@ubicast.eu>"

ENV VENV /usr/local/pyvenv
ENV PATH ${VENV}/bin:${PATH}

RUN apk add \
    bash \
    git \
    make \
    openssh-client \
    python3
COPY --from=builder /usr/local/bin/* /usr/local/bin/
COPY --from=builder ${VENV} ${VENV}