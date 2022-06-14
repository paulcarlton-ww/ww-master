#!/usr/bin/env bash

# Utility for creating docker remote k8s builder
# Version: 1.0
# Author: Paul Carlton (mailto:paul.carlton@weave.works)

docker buildx create \
  --name remote-kubernetes \
  --driver remote \
  --driver-opt cacert=ca.pem,cert=cert.pem,key=key.pem \
  tcp://buildkitd.default.svc:1234