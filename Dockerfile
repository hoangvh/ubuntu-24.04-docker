FROM ubuntu:24.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set default timezone (can be overridden by mounting host files)
ENV TZ=Asia/Ho_Chi_Minh

# Install base packages and build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git wget locales tzdata sudo \
    bc bison build-essential ccache debootstrap device-tree-compiler \
    dosfstools fakeroot flex gawk gcc \
    gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu \
    g++-arm-linux-gnueabihf g++-aarch64-linux-gnu \
    kmod libncurses-dev libssl-dev libzstd-dev parted pkg-config \
    python3 python3-pip python3-setuptools \
    rsync swig tar unzip xz-utils zip zlib1g-dev \
    qemu-user-static qemu-utils openssh-client\
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Docker Engine and Docker Compose
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/docker.list \
 && apt-get update && apt-get install -y --no-install-recommends \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /root

# Default command
CMD ["/bin/bash"]
