# Configure AWS client for EKS authentication.
#
cat ~/.aws/credentials | sed s/^\\[sts\\]$/\[default\]/ > ~/.aws/amp_tekton_builder_system_user-credentials
export KUBECONFIG=~/.kube/kubeconfig_tekton-builder.yaml

# Create builder for ARM64.
#
docker buildx create --name arm64builder \
--platform linux/arm64 \
--driver kubernetes \
--driver-opt namespace=tekton-builder,replicas=1,nodeselector=beta.kubernetes.io/arch=arm64,rootless=true

# Create builder for AMD64.
#
$ docker buildx create --name amd64builder \
--platform linux/amd64 \
--driver kubernetes \
--driver-opt namespace=tekton-builder,replicas=1,nodeselector=beta.kubernetes.io/arch=amd64,rootless=true

# List the builders in Docker.
#
$ docker buildx ls
NAME/NODE DRIVER/ENDPOINT STATUS PLATFORMS
amd64builder  kubernetes  
 amd64builder0-55ff5c7fff-jjzn7  running linux/amd64*, linux/386
arm64builder  kubernetes  
 arm64builder0-56cb9fd45f-k2s5r  running linux/arm64*, linux/arm/v7, linux/arm/v6
default * docker  
 default default  running linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6

# Build Dockerfile for ARM64 using BuildKit.
#
$ docker buildx build --builder arm64builder . \
    -f Dockerfile \
    -t arm64-build-test:latest \
    --load

# Build Dockerfile for AMD64 using BuildKit.
#
$ docker buildx build --builder amd64builder . \
    -f Dockerfile \
    -t amd64-build-test:latest \
    --load

# Check the container images.
#
$ docker images | grep build-test

# Inspect container images.
#
$ docker inspect arm64-build-test:latest | grep Architecture
 "Architecture": "arm64",
$ docker inspect amd64-build-test:latest | grep Architecture
 "Architecture": "amd64",