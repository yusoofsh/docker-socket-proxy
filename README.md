# Docker Socket Proxy

This repository builds the pinned Docker Socket Proxy helper used by the
Lighthouse stack. The workflow publishes an immutable GitHub Container
Registry candidate and verifies read-only container access plus rejection of
the Docker ping POST endpoint.

The production Compose configuration and Docker socket remain managed by the
Lighthouse deployment repository.

