FROM bitnami/kubectl:latest as kubectl
FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install software-properties-common -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    wget \
    default-jdk \
    default-jre \
    maven \
    python3 \
    python3-pip \
    # .NET dependencies
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu66 \
    libssl1.1 \
    libstdc++6 \
    zlib1g \
    nodejs \
    npm
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN curl -fsSL https://get.docker.com | sh
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
WORKDIR /azp
COPY ./start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "./start.sh" ]
