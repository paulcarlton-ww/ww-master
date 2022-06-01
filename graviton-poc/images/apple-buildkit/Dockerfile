ARG BUILDKIT_VERSION=v0.9.3-rootless
FROM moby/buildkit:${BUILDKIT_VERSION} as main

USER root

ADD https://certificatemanager.fs.com/certs/fs_corporate_root_ca.pem \
    https://certificatemanager.fs.com/certs/fs_corporate_root_ca2.pem \
    https://certificatemanager.fs.com/certs/fs_corporate_server_ca_1.pem \
    https://certificatemanager.fs.com/certs/fs_corporate_server_ca_2.pem \
    /usr/local/share/ca-certificates/
RUN update-ca-certificates

USER user
