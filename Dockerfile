FROM bitnami/kubectl:latest as kubectl
FROM jenkins/inbound-agent:latest-jdk17
USER root
RUN apt update && apt upgrade -y && apt-get install git curl -y && curl -fsSL https://get.docker.com | sh
RUN mkdir -p /usr/share/man/man1
RUN apt-get install nodejs maven -y
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
