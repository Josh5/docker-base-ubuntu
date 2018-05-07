FROM ubuntu:16.04
MAINTAINER Josh.5 "jsunnex@gmail.com"

# Create default user
RUN useradd --create-home --home-dir /home/docker docker
RUN chown -R docker:docker /home/docker
ENV HOME /home/docker
WORKDIR $HOME

# set version for s6 overlay
ARG OVERLAY_VERSION="v1.21.2.2"
ARG OVERLAY_ARCH="amd64"

# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)$ " \
    HOME="/root" \
    TERM="xterm"

RUN \
    echo "**** install build packages ****" && \
        apt-get update && \
        apt-get install -y \
            curl \
            tar \
            unzip \
        && \
    echo "**** install runtime packages ****" && \
        apt-get install -y \
            bash-completion \
            openssh-server \
            ca-certificates \
            coreutils \
            tzdata \
            nano \
        && \
    echo "**** add s6 overlay ****" && \
        curl -o \
            /tmp/s6-overlay.tar.gz -L \
            "https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz" && \
        tar xfz \
            /tmp/s6-overlay.tar.gz -C / \
        && \
    echo "**** create docker user and make our folders ****" && \
        mkdir -p \
            /app \
            /config \
            /defaults \
        && \
    echo "**** enable remote ssh access ****" && \
        sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
        && \
        echo "root:root" | chpasswd \
    echo "**** cleanup ****" && \
        rm -rf /var/lib/apt/lists/*

# add local files
COPY root/ /

ENTRYPOINT ["/init"]