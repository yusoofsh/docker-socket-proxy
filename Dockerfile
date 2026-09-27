# syntax=docker/dockerfile:1
FROM tecnativa/docker-socket-proxy@sha256:1f5038b54f06c3e18422902cf00ba21803d1c97805aae032e5e6673d532d3459
# Keep the upstream HAProxy configuration, ACLs and entrypoint unchanged.
RUN apk add --no-cache 'libcrypto3=3.5.8-r0' 'libssl3=3.5.8-r0'

LABEL org.opencontainers.image.source="https://github.com/yusoofsh/docker-socket-proxy"
