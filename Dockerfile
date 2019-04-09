FROM debian:stable-slim
LABEL maintainer="Nicolas Karolak <nicolas.karolak@ubicast.eu>"

ENV ANSIBLE_VERSION=2.7.10
ENV TERRAFORM_VERSION=0.11.13

RUN \
    apt update && \
    apt install -y wget unzip && \
    wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    apt install -y python3-minimal python3-pip && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/* /tmp/*
