FROM golang:buster

RUN apt-get update && apt-get --no-install-recommends -y install \
    unzip \
    jq;

# All releases: https://github.com/gotestyourself/gotestsum/releases
RUN curl -sSL "https://github.com/gotestyourself/gotestsum/releases/download/v0.4.1/gotestsum_0.4.1_linux_amd64.tar.gz" | tar -xz -C /usr/local/bin gotestsum

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]