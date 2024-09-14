FROM debian:trixie-slim

RUN apt update \
&& apt upgrade -y \
&& apt install -y sudo git neovim nano man curl wget \
               python3 python3-pip python-is-python3 \
               --no-install-recommends \
&& apt clean autoclean \
&& apt autoremove -y \
&& rm -rf /var/lib/apt/lists/* \
&& rm /usr/lib/python*/EXTERNALLY-MANAGED 