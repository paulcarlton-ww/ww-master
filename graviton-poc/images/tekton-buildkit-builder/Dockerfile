FROM oraclelinux:8.6
SHELL ["/bin/bash", "-eou", "pipefail", "-c"]

ARG DOCKER_CE_CLI_VERSION="20.10.12"
RUN dnf install -y dnf-utils zip unzip; \
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo; \
    dnf install -y --nodocs \
        #groff \ #TODO: Install groff from the centos repos? It is only needed for aws cli `help`
        docker-ce-cli-${DOCKER_CE_CLI_VERSION} \
        file \
        git \
        less \
        unzip \
    ; \
    dnf clean all;

ARG KUBECTL_VERSION="v1.22.3"
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl; \
    mv kubectl /usr/local/bin/kubectl; chmod +x /usr/local/bin/kubectl

ARG AWS_CLI_VERSION="2.7.6"
# hadolint ignore=DL3003
RUN cd /tmp || exit 1; \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" \
        -o "/tmp/awscliv2.zip"; \
    unzip "/tmp/awscliv2.zip" >/dev/null; \
    /tmp/aws/install; \
    rm -rf /tmp/aws;

RUN useradd build_user; \
    echo "build_user  ALL=(ALL)  NOPASSWD: /usr/bin/docker" >> /etc/sudoers; \
    echo "alias docker=\"sudo /usr/bin/docker\"" >> /home/build_user/.bash_profile

USER build_user
