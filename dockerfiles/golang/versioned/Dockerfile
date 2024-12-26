FROM docker.io/sololaboratories/base:debian-trixie
ARG GOLANG_VERSION=1.23.4

RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz 

# Setup go env vars
ENV GOROOT=/usr/local/go
ENV PATH=$PATH:$GOROOT/bin

ENV GOPATH=/home/coder/go
ENV GOBIN=$GOPATH/bin
ENV PATH=$PATH:$GOBIN

USER coder