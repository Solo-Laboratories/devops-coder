FROM docker.io/sololaboratories/base:debian-trixie

COPY install_latest_go.sh /
RUN ./install_latest_go.sh && rm -f /install_latest_go.sh

# Setup go env vars
ENV GOROOT=/usr/local/go
ENV PATH=$PATH:$GOROOT/bin

ENV GOPATH=/home/coder/go
ENV GOBIN=$GOPATH/bin
ENV PATH=$PATH:$GOBIN

RUN echo "export PATH=\"$PATH:/usr/local/go/bin\"" >> /etc/profile

USER coder
