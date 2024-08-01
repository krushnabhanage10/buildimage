FROM bitnami/kubectl:latest as kubectl
FROM jenkins/inbound-agent:latest-jdk21
USER root
RUN apt update && apt upgrade -y && apt-get install git curl apt-transport-https lsb-release gnupg wget software-properties-common -y && curl -fsSL https://get.docker.com | sh
RUN mkdir -p /usr/share/man/man1
RUN apt-get install nodejs maven -y
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN curl -fsSL https://get.docker.com | sh
RUN apt-get install && apt-get update && apt-get install -y azure-cli dotnet-sdk-6.0
RUN az bicep install
RUN rm powershell_7.4.4-1.deb_amd64.deb packages-microsoft-prod.deb && apt-get clean && rm -rf /var/lib/apt/lists/*
