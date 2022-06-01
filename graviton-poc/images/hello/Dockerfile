FROM alpine:3 AS fs-alpine-base

ADD https://certificatemanager.fs.com/certs/fs_corporate_root_ca.pem \
    https://certificatemanager.fs.com/certs/fs_corporate_root_ca2.pem \
    https://certificatemanager.fs.com/certs/fs_corporate_server_ca_1.pem \
    https://certificatemanager.fs.com/certs/fs_corporate_server_ca_2.pem \
    /usr/local/share/ca-certificates/

RUN apk add --no-cache "ca-certificates>=0" && \
    update-ca-certificates && \
    sed -i'' -r 's%dl-cdn\.alpinelinux\.org/alpine%artifacts.fs.com/alpinelinux-dist%' /etc/apk/repositories

FROM fs-alpine-base as builder-base
RUN apk add --no-cache "build-base>=0.5"

FROM builder-base as builder
WORKDIR /home
COPY src/ .
RUN gcc "-DARCH=\"$(uname -sm)\"" hello.c -o hello

FROM scratch as raw
WORKDIR /
COPY --from=builder /home/hello .

FROM alpine:3 AS final
WORKDIR /home
COPY --from=builder /home/hello .
ENTRYPOINT ["./hello"]
