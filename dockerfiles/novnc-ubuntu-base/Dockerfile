# 
# Pushed to DockerHub 2023-03-12 as marktmilligan/tigervnc:latest
#
# https://serverfault.com/questions/376302/tigervnc-ssh-without-a-vnc-password
#

# the base image 
FROM codercom/enterprise-base:ubuntu

USER root

# Install baseline packages
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --yes \
    ubuntu-mate-desktop \
    firefox \
    tigervnc-standalone-server \
    sudo \
    supervisor

RUN update-alternatives --config x-terminal-emulator

# configure script to start supervisord
COPY ["configure", "/coder/configure"]
RUN chmod +x /coder/configure

# copy supervisord config
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY xstartup /coder/xstartup

# Modify to include my user
ARG USER=markus
RUN useradd --create-home --groups sudo --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT["/coder/start_vnc"]