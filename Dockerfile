FROM ubuntu:20.04 as base

# rbenv-installer downloaded from https://raw.githubusercontent.com/rbenv/rbenv-installer/b53c0f133e2eae0ddfceecd7bdfb9e4997280444/bin/rbenv-installer
COPY usr/local/bin/rbenv-installer /usr/local/bin/rbenv-installer

WORKDIR /root

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
        libreadline-dev \
        libssl-dev \
        libyaml-dev \
        nginx \
        vim \
        zlib1g-dev

RUN /usr/local/bin/rbenv-installer \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bashrc \
    && echo 'eval "$(.rbenv/bin/rbenv init -)"' >> .bashrc \
    && git clone https://github.com/rbenv/ruby-build.git \
    && PREFIX=/usr/local ruby-build/install.sh \
    && rm -rf ruby-build \
    && .rbenv/bin/rbenv install 2.7.6 \
    && .rbenv/bin/rbenv global 2.7.6 \
    && echo 'gem: --no-document' > .gemrc \
    && .rbenv/shims/gem install bundler rails puma \
    && git clone https://github.com/bats-core/bats-core.git \
    && bats-core/install.sh /usr/local \
    && rm -rf bats-core

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
