FROM ubuntu:22.04

ARG GLAB_VERSION=1.40.0
ARG GOLANG_VERSION=1.22.4

RUN apt update && \

	apt install wget curl sudo wget ca-certificates git -y --no-install-recommends && \
	wget https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_Linux_x86_64.deb && dpkg -i glab_${GLAB_VERSION}_Linux_x86_64.deb && rm -f glab_${GLAB_VERSION}_Linux_x86_64.deb

ARG USER=markus
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \

	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}

RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && tar -C /home/${USER} -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV PATH="${PATH}:/home/${USER}/go/bin"
