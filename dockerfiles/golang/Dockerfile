ARG GOLANG_VERSION=1.23.0
FROM docker.io/sololaboratories/base:debian

RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && tar -C ${HOME} -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && mv ${HOME}/go/bin/* /usr/local/bin/