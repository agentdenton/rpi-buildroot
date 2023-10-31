FROM ubuntu:22.04

ARG CONTAINER_USERNAME
ARG WORKDIR_PATH

# Set non-interactive frontend for apt-get to skip any user confirmations
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && apt-get update && apt-get install -y \
    locales \
    vim \
    sudo \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    cpio \
    diffutils \
    file \
    findutils \
    gzip \
    libarchive-tools \
    make \
    patch \
    perl \
    rsync \
    sed \
    tar \
    unzip \
    wget \
    git

RUN useradd --shell=/bin/bash --create-home $CONTAINER_USERNAME
RUN echo "$CONTAINER_USERNAME ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

USER $CONTAINER_USERNAME

RUN mkdir -p $WORKDIR_PATH
WORKDIR $WORKDIR_PATH

ENV HOME="/home/$CONTAINER_USERNAME"
ENV PATH="$HOME/.local/bin:$PATH"

CMD ["/bin/bash"]
