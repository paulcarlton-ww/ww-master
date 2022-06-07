FROM oraclelinux:8.6 as main
SHELL ["/bin/bash", "-eou", "pipefail", "-c"]

ARG DOCKER_CE_CLI_VERSION="20.10.12"
RUN yum install -y git curl unzip 

ARG KUBECTL_VERSION="v1.22.3"
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN mv kubectl /usr/local/bin/kubectl; chmod +x /usr/local/bin/kubectl

ARG AWS_CLI_VERSION="2.7.6"
# hadolint ignore=DL3003
RUN cd /tmp || exit 1; \
    # TODO: Proxy this through artifacts.fs.com?
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" \
        -o "/tmp/awscliv2.zip"; \
    unzip "/tmp/awscliv2.zip"; \
    /tmp/aws/install; \
    rm -rf /tmp/aws;

FROM main as test
RUN docker buildx version; \
    aws --version; \
    kubectl version --client=true

FROM main as final
