FROM bitnami/kubectl:latest as kubectl
FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install software-properties-common -y
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
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
    zlib1g
RUN rm -rf /var/lib/apt/lists/*
RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin -Channel 6.0 -Runtime dotnet -InstallDir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64
RUN curl -fsSL https://get.docker.com | sh
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
WORKDIR /azp
COPY ./start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "./start.sh" ]