# Docker Socket Proxy

This repository builds the current upstream default `master` commit of Docker
Socket Proxy directly, retaining its HAProxy configuration and entrypoint.
The source archive and base image are pinned by digest for reproducibility,
while the workflow publishes both an immutable candidate and `:latest`.
It verifies read-only container access plus rejection of the Docker ping POST
endpoint.

The production Compose configuration and Docker socket remain managed by the
Lighthouse deployment repository.

## Version tags

Each published build also has a `sha-<commit>` tag. To give a build a version, push a git tag named `vYYYY.MM.DD-ys.N` on a commit of `main` whose image has finished publishing. The `Tag released image` workflow then adds `ghcr.io/yusoofsh/docker-socket-proxy:YYYY.MM.DD-ys.N` to that exact image. It never moves a version tag that already exists, and a tag push does not rebuild or redeploy anything. Pin deployments to the version tag.
