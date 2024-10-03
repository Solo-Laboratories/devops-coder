FROM docker.io/sololaboratories/base:debian
ARG GOLANG_VERSION=1.23.2

RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && tar -C ${HOME} -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && mv ${HOME}/go/bin/* /usr/local/bin/