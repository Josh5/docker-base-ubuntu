
# josh5/docker-ubuntu-base

### Based upon [Ubuntu Linux](https://hub.docker.com/_/ubuntu/) and [S6 overlay](https://github.com/just-containers/s6-overlay), this serves as a base template container for all other docker containers created by Josh.5.

### Builds "josh5/base-ubuntu<VERSION>"

```
UBUNTU_VERSION=16.04
docker build -t josh5/base-ubuntu${UBUNTU_VERSION} .
```
