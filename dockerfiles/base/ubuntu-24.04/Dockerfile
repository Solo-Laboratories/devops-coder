FROM ubuntu:24.04

RUN apt update \
&& apt upgrade -y \
&& apt install -y sudo git neovim nano man curl wget gnupg dirmngr ca-certificates apt-transport-https xz-utils \
               lsb-release jq software-properties-common openssh-client \
               python3 python3-pip python-is-python3 \
               --no-install-recommends \
&& apt clean autoclean \
&& apt autoremove -y \
&& rm -rf /var/lib/apt/lists/* \
&& rm /usr/lib/python*/EXTERNALLY-MANAGED 

ARG USER=coder
# ubuntu has a user called 'ubunut' as 1000:1000 so $USER will be 1001:1001; FYI
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
