FROM golang:buster

RUN apt-get update && apt-get --no-install-recommends -y install \
    git \
    unzip \
    python-pip \
    go-dep ;

# Install gotestsum for parsing test output
RUN curl -sSL "https://github.com/gotestyourself/gotestsum/releases/download/v0.4.0/gotestsum_0.4.0_linux_amd64.tar.gz" | tar -xz -C /usr/local/bin gotestsum

# Install awscli
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws;

# Install packer
RUN curl "https://releases.hashicorp.com/packer/1.4.5/packer_1.4.5_linux_amd64.zip" -o "packer.zip" && \
    unzip packer.zip && \
    mv packer /usr/local/bin && \
    chmod a+x /usr/local/bin/packer

RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
RUN echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile && ln -s ~/.tfenv/bin/* /usr/local/bin
RUN tfenv install 0.12.9

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

