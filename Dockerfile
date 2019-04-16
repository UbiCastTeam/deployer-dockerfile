FROM debian:stable-slim

LABEL maintainer="Nicolas Karolak <nicolas.karolak@ubicast.eu>"

ENV PATH="/root/.poetry/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q && apt-get install -y -q openssh-client python3-minimal python3-pip python3-venv unzip wget

ENV PACKER_VERSION=1.4.0
ENV PACKER_URL=https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
RUN wget -O /tmp/packer.zip ${PACKER_URL} && unzip /tmp/packer.zip -d /usr/local/bin

ENV TERRAFORM_VERSION=0.11.13
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN wget -O /tmp/terraform.zip ${TERRAFORM_URL} && unzip /tmp/terraform.zip -d /usr/local/bin

ENV TERRAFORM_INVENTORY_VERSION=0.8
ENV TERRAFORM_INVENTORY_URL=https://github.com/adammck/terraform-inventory/releases/download/v${TERRAFORM_INVENTORY_VERSION}/terraform-inventory_v${TERRAFORM_INVENTORY_VERSION}_linux_amd64.zip
RUN wget -O /tmp/terraform-inventory.zip ${TERRAFORM_INVENTORY_URL} && unzip /tmp/terraform-inventory.zip -d /usr/local/bin

ENV POETRY_VERSION=0.12.12
ENV POETRY_URL=https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py
RUN wget -qO- ${POETRY_URL} | python3 && sed -i 's/python/python3/' /root/.poetry/bin/poetry

ENV AMICLEANER_VERSION=0.2.2
RUN pip3 install aws-amicleaner==${AMICLEANER_VERSION}

RUN apt-get clean && rm -rf /tmp/* /var/cache/* /var/log/* /var/lib/apt/list/*
