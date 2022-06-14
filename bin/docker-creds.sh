#!/usr/bin/env bash

# Utility for creating docker credentials secret
# Version: 1.0
# Author: Paul Carlton (mailto:paul.carlton@weave.works)
set -x
kubectl create secret docker-registry --dry-run=client docker-creds \
--docker-server=https://index.docker.io/v1/ \
--docker-username=$DOCKER_USER \
--docker-password=$DOCKER_PASSWORD \
--docker-email=$DOCKER_EMAIL \
--namespace=tekton-builder \
-o yaml > docker-secret.yaml