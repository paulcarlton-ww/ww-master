# See more about this file: https://docs.docker.com/engine/reference/commandline/buildx_bake/
# Valid target fields:
# args, cache-from, cache-to, context, dockerfile, inherits,
# labels, no-cache, output, platform, pull, secrets, ssh, tags, target

group "default" {
    targets = [
        "fs-buildkit-arm64",
        "fs-buildkit-amd64",
        "tekton-buildkit-builder",
        "hello-arm64",
        "hello-amd64",
    ]
}

group "fs-buildkit" {
    targets = [
        "fs-buildkit-arm64",
        "fs-buildkit-amd64",
    ]
}

group "hello-local" {
    targets = [
        "hello-arm64",
        "hello-amd64",
    ]
}

group "hello-publish" {
    targets = [
        "hello-arm64-dockerload",
        "hello-amd64-dockerload",
        "hello-arm64-raw",
        "hello-amd64-raw",
    ]
}

group "fs-buildkit-publish" {
    targets = [
        "fs-buildkit-arm64-dockerload",
        "fs-buildkit-amd64-dockerload",
    ]
}

group "tekton-buildkit-builder-publish" {
    targets = [
        "tekton-buildkit-builder-dockerload",
    ]
}

target "fs-buildkit-arm64" {
    context = "images/fs-buildkit"
    tags = ["pcarlton/fs-buildkit:latest-arm64"]
    platforms = ["linux/arm64"]
}

target "fs-buildkit-amd64" {
    context = "images/fs-buildkit"
    tags = ["pcarlton/fs-buildkit:latest-amd64"]
    platforms = ["linux/amd64"]
}

target "fs-buildkit-arm64-dockerload" {
    inherits = ["fs-buildkit-arm64"]
    output = [
        "type=docker,dest=.out/fs-buildkit-dockerload-arm64.tar"
    ]
}

target "fs-buildkit-amd64-dockerload" {
    inherits = ["fs-buildkit-amd64"]
    output = [
        "type=docker,dest=.out/fs-buildkit-dockerload-amd64.tar"
    ]
}

target "hello-amd64" {
    context = "images/hello"
    tags = ["docker.fs.com/graviton-poc/hello:latest-amd64"]
    platforms = ["linux/amd64"]
}

target "hello-arm64" {
    context = "images/hello"
    tags = ["docker.fs.com/graviton-poc/hello:latest-arm64"]
    platforms = ["linux/arm64"]
}

target "hello-amd64-raw" {
    inherits = ["hello-amd64"]
    target = "raw"
    output = [
        "type=local,dest=.out/raw-amd64",
    ]
}

target "hello-arm64-raw" {
    inherits = ["hello-arm64"]
    target = "raw"
    output = [
        "type=local,dest=.out/raw-arm64",
    ]
}

target "hello-amd64-dockerload" {
    inherits = ["hello-amd64"]
    output = [
        "type=docker,dest=.out/hello-dockerload-amd64.tar"
    ]
}

target "hello-arm64-dockerload" {
    inherits = ["hello-arm64"]
    output = [
        "type=docker,dest=.out/hello-dockerload-arm64.tar"
    ]
}

target "tekton-buildkit-builder" {
    context = "images/tekton-buildkit-builder"
    tags = ["pcarlton/buildkit-builder:latest"]
    platforms = ["linux/amd64"]
}

target "tekton-buildkit-builder-dockerload" {
    inherits = ["tekton-buildkit-builder"]
    output = [
        "type=docker,dest=.out/tekton-buildkit-builder-dockerload.tar"
    ]
}
