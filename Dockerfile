FROM ubuntu:16.04
MAINTAINER Josh.5 "jsunnex@gmail.com"

################
### CONFIG:
###
# set version for s6 overlay
ARG OVERLAY_VERSION="v1.21.2.2"
ARG OVERLAY_ARCH="amd64"


# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)$ " \
    HOME="/root" \
    TERM="xterm"
WORKDIR $HOME

RUN \
    echo "**** install build packages ****" \
        && apt-get update \
        && apt-get install -y \
            curl \
            tar \
            unzip \
            xz-utils \
    && \
    echo "**** install runtime packages ****" \
        && apt-get install -y \
            bash-completion \
            ca-certificates \
            coreutils \
            tzdata \
            nano \
    && \
    echo "**** add s6 overlay ****" \
        && curl -o \
            /tmp/s6-overlay.tar.gz -L \
            "https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz" \
        && tar xfz \
            /tmp/s6-overlay.tar.gz -C / \
    && \
    echo "**** create docker user and make our folders ****" \
        && groupmod -g 1000 users \
        && useradd -u 1000 -U -d /config -s /bin/false docker \
        && usermod -G users docker \
        && mkdir -p \
            /app \
            /config \
            /defaults \
    && \
    echo "**** cleanup ****" \
        && rm -rf /tmp/* \
        && rm -rf /var/lib/apt/lists/*

# add local files
COPY root/ /

ENTRYPOINT ["/init"]