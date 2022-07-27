##
## Base
##
FROM ubuntu:20.04 as base


RUN apt-get update \
    && DEBIAN_FRONTEND=noninternactive \
    apt-get install --yes --no-install-recommends \
        autoconf \
        bison \
        build-essential \
        ca-certificates \
        curl \
        git \
        libffi-dev \
        libgdbm-dev \
        libncurses5-dev \
        libreadline-dev \
        libssl-dev \
        libyaml-dev \
        nginx \
        vim \
        xz-utils \
        zlib1g-dev

# rbenv-installer downloaded from https://raw.githubusercontent.com/rbenv/rbenv-installer/b53c0f133e2eae0ddfceecd7bdfb9e4997280444/bin/rbenv-installer
COPY sbin/* /sbin/

WORKDIR /root

RUN /sbin/rbenv-installer \
    && /sbin/install-bats \
    && /sbin/install-ruby-build \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bashrc \
    && echo 'eval "$(.rbenv/bin/rbenv init -)"' >> .bashrc \
    && .rbenv/bin/rbenv install 2.7.6 \
    && .rbenv/bin/rbenv global 2.7.6 \
    && echo 'gem: --no-document' > .gemrc \
    && .rbenv/shims/gem install bundler rails puma

##
## S6
##
FROM base as s6

ARG S6_OVERLAY_VERSION=3.1.1.2

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

##
## Tests
##
FROM base as test

COPY root/tests/* /root/tests/

RUN bash -c 'PATH="/root/.rbenv/shims:${PATH}" bats --tap /root/tests'

##
## Final image
##
FROM base

COPY --from=s6 /package /package
COPY --from=s6 /command /command
COPY --from=s6 /etc/s6-overlay /etc/s6-overlay
COPY --from=s6 /init /init
