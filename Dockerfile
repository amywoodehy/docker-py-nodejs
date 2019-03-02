FROM python:3.6
MAINTAINER Amy Woodehy <amywoodehy@gmail.com>


ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 0

RUN \
    apt-get update && \
    apt-get install -yqq \
        libpq-dev gcc \
        python3-dev python3-pip \
        gettext \
        apt-utils apt-transport-https \
        vim && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip

# Install node prereqs, nodejs 10.x and yarn
# Ref: https://deb.nodesource.com/setup_10.x
# Ref: https://yarnpkg.com/en/docs/install
# Source: https://github.com/nikolaik/docker-python-nodejs/
RUN \
    DISTRO="$(lsb_release -s -c)" && \
    echo "deb https://deb.nodesource.com/node_10.x $DISTRO main" > /etc/apt/sources.list.d/nodesource.list && \
    wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -yqq\
        nodejs yarn && \
    rm -rf /var/lib/apt/lists/*

CMD ["bash"]
