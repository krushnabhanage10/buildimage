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
    zlib1g
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb
RUN apt-get update &&\
    apt-get install -y dotnet-sdk-6.0 &&\
    rm packages-microsoft-prod.deb &&\
    rm -rf /var/lib/apt/lists/* &&\
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash
# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64
RUN curl -fsSL https://get.docker.com | sh

RUN curl -sL https://deb.nodesource.com/setup | sudo bash - && apt-get install -yq nodejs build-essential &&\
    npm install -g npm &&\
    npm install -g yo grunt-cli bower express &&\
    which node &&\
    node -v &&\
    which npm &&\ 
    npm -v; &&\
    npm ls -g --depth=0

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
WORKDIR /azp
COPY ./start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "./start.sh" ]
