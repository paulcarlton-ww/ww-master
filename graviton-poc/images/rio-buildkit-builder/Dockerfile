ARG OEL8_VERSION=8-slim
FROM pcarlton/fs-oraclelinux:${OEL8_VERSION} as main
SHELL ["/bin/bash", "-eou", "pipefail", "-c"]

COPY docker-ce.repo /etc/yum.repos.d/

ARG DOCKER_CE_CLI_VERSION="20.10.12"
RUN microdnf install -y --nodocs \
        #groff \ #TODO: Install groff from the centos repos? It is only needed for aws cli `help`
        docker-ce-cli-${DOCKER_CE_CLI_VERSION} \
        file \
        git \
        less \
        unzip \
    ; \
    microdnf clean all;

ARG KUBECTL_VERSION="v1.22.3"
RUN curl -L "https://artifacts.fs.com/storage-googleapis/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
        -o "/usr/local/bin/kubectl"; \
    chmod +x "/usr/local/bin/kubectl";

ARG AWS_CLI_VERSION="2.0.30"
# hadolint ignore=DL3003
RUN cd /tmp || exit 1; \
    # TODO: Proxy this through artifacts.fs.com?
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" \
        -o "/tmp/awscliv2.zip"; \
    unzip "/tmp/awscliv2.zip"; \
    /tmp/aws/install; \
    rm -rf /tmp/aws;

ARG PCL_VERSION="0.19.2"
RUN curl https://artifacts.fs.com/libs-release/com/fs/pcl/pcl-cli-alpine/${PCL_VERSION}/pcl-cli-alpine-${PCL_VERSION}.bin \
        -o /bin/pcl; \
    chmod +x /bin/pcl;

FROM main as test
RUN docker buildx version; \
    aws --version; \
    kubectl version --client=true; \
    pcl --version;

FROM main as final
