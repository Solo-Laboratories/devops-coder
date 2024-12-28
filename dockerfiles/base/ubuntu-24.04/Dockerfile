FROM ubuntu:24.04

RUN apt update \
&& apt upgrade -y \
&& apt install -y sudo git neovim nano man curl wget gnupg dirmngr ca-certificates apt-transport-https xz-utils \
               lsb-release jq software-properties-common \
               python3 python3-pip python-is-python3 \
               --no-install-recommends \
&& apt clean autoclean \
&& apt autoremove -y \
&& rm -rf /var/lib/apt/lists/* \
&& rm /usr/lib/python*/EXTERNALLY-MANAGED 

ARG USER=coder
RUN usermod -l ${USER} ubuntu \
	&& chsh -s /bin/bash \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
