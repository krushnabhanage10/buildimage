FROM bitnami/kubectl:latest as kubectl
FROM jenkins/inbound-agent:latest-jdk11
USER root
RUN apt update && apt upgrade -y && apt-get install git curl -y && curl -fsSL https://get.docker.com | sh
Run apt-get install nodejs maven -y
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
