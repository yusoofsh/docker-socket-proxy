# syntax=docker/dockerfile:1

# Pin the current upstream master tree and build its Dockerfile contents
# directly so the ACLs and entrypoint cannot drift from the source branch.
FROM alpine:3.23@sha256:85fe1e81d6758c208f3e1eed4338a1997e19d4be002d4dd32d3100c9a8c010a0 AS source

ADD https://github.com/Tecnativa/docker-socket-proxy/archive/2e118a0c0c66e1831f68b7afd6d49ad3e2f96b5d.tar.gz /tmp/source.tar.gz
RUN echo '4e72220d7ab7aabaae70dc3402680bb85864a781c58177f37815a25934dfc031  /tmp/source.tar.gz' | sha256sum -c - \
	&& mkdir -p /src \
	&& tar -xzf /tmp/source.tar.gz --strip-components=1 -C /src

FROM haproxy:3.4.2-alpine@sha256:0878b11eb64c433be1b0f578a584b8aca12f6caaa64c8f239b8b556c0dd5eeeb

EXPOSE 2375
ENV ALLOW_RESTARTS=0 \
	ALLOW_STOP=0 \
	ALLOW_START=0 \
	AUTH=0 \
	BUILD=0 \
	COMMIT=0 \
	CONFIGS=0 \
	CONTAINERS=0 \
	DISABLE_IPV6=0 \
	DISTRIBUTION=0 \
	EVENTS=1 \
	EXEC=0 \
	GRPC=0 \
	IMAGES=0 \
	INFO=0 \
	LOG_LEVEL=info \
	NETWORKS=0 \
	NODES=0 \
	PING=1 \
	PLUGINS=0 \
	POST=0 \
	SECRETS=0 \
	SERVICES=0 \
	SESSION=0 \
	SOCKET_PATH=/var/run/docker.sock \
	SWARM=0 \
	SYSTEM=0 \
	TASKS=0 \
	VERSION=1 \
	VOLUMES=0

COPY --from=source /src/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY --from=source /src/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg.template
RUN apk add --no-cache 'libcrypto3=3.5.8-r0' 'libssl3=3.5.8-r0' \
	&& touch /var/lib/haproxy/server-state

LABEL org.opencontainers.image.source="https://github.com/yusoofsh/docker-socket-proxy" \
	org.opencontainers.image.revision="2e118a0c0c66e1831f68b7afd6d49ad3e2f96b5d"

USER root
CMD ["haproxy", "-f", "/tmp/haproxy.cfg"]
