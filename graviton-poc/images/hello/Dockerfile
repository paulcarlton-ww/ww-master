FROM alpine:3 as builder-base
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
