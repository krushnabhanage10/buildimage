FROM bitnami/kubectl:latest as kubectl
FROM jenkins/inbound-agent:latest-jdk17
USER root
RUN apt update && apt upgrade -y && apt-get install git curl apt-transport-https lsb-release gnupg -y && curl -fsSL https://get.docker.com | sh
RUN mkdir -p /usr/share/man/man1
RUN apt-get install nodejs maven -y
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update && apt-get install -y azure-cli powershell
RUN az bicep install
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
