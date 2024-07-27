FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends git

RUN snap install zig --classic --beta

ARG USER=markus
RUN useradd --groups sudo --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}