FROM debian:trixie-slim

RUN apt update \
&& apt upgrade -y \
&& apt install -y sudo git neovim nano man curl wget gnupg dirmngr ca-certificates apt-transport-https xz-utils \
               lsb-release jq add-apt-repository \
               python3 python3-pip python-is-python3 \
               --no-install-recommends \
&& apt clean autoclean \
&& apt autoremove -y \
&& rm -rf /var/lib/apt/lists/* \
&& rm /usr/lib/python*/EXTERNALLY-MANAGED 

ARG USER=coder
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}