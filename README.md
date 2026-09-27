# Docker Socket Proxy

This repository builds the current upstream default `master` commit of Docker
Socket Proxy directly, retaining its HAProxy configuration and entrypoint.
The source archive and base image are pinned by digest for reproducibility,
while the workflow publishes both an immutable candidate and `:latest`.
It verifies read-only container access plus rejection of the Docker ping POST
endpoint.

The production Compose configuration and Docker socket remain managed by the
Lighthouse deployment repository.
