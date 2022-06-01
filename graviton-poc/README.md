# Multi-Platform Docker Image and Binary Build POC

## Introduction

This repository serves as an example for how to build multi-platform container images using:

* Docker BuildKit
* Remote BuildKit instances running on a mixed AMD64/ARM64 EKS cluster.


## Prerequisites

1. AWS EKS cluster configured with both AMD64 worker nodes, and ARM64 worker node instances based on Graviton.
2. You have access to the `kubeconfig` file associated with the AWS EKS cluster.
   Suggested location: `~/.kube/kubeconfig_tekton-builder.yaml`
3. You have access to AWS access key id and secret access key associated with the user account in the AWS EKS cluster.
   Suggested location: `~/.aws/amp_tekton_builder_system_user-credentials`
   
    ```toml
    [default]
    aws_access_key_id = XXXXXXXXXXXXXXXXXXXX 
    aws_secret_access_key = XXXXXXXXXXX
    ```
4. You have a docker image with `kubectl`, the `aws` cli, and `docker buildx`.
   See the [fs-graviton-builder](images/fs-graviton-builder/README.md) image.

## `Dockerfile`

The [`Dockerfile`](images/hello/Dockerfile) and [`hello.c`](images/hello/src/hello.c) are used for creating the ARM64 and AMD64 container image build in the POC.

## Deploying BuildKit into AWS EKS

To support ARM64 and AMD64 container image builds, we need to deploy BuildKit daemons into the AWS EKS cluster.
Notice that the container image builds will require loading base container images from fs’s Artifactory, hence the BuildKit daemons must have fs Corporate CA certificates configured.
The BuildKit builder instances are now deployed or reused automatically as part of the [`bin/build`](bin/build) script.

## Building Dockerfile for ARM64 and AMD64 architectures

Just run [`bin/build-local`](bin/build-local)!
