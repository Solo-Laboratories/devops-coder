FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=markus
ENV HOME=/home/$USER

# Install MATE and dependency component.
RUN apt-get update \
    && apt-get install -y \
        tightvncserver \
        ubuntu-mate-desktop \
        supervisor \
        firefox \
        net-tools \
        curl \
        git \
        pwgen \
        sudo \
        wget \
        unzip \
        zsh \
        xorg \
        x11-apps \
        dbus-x11 \
        xterm \
        python-numpy \
        fonts-lyx \
        libxtst6 \
        libxv1 \
        libglu1-mesa \
        libc6-dev \
        libglu1 \
        libsm6 \
        libxv1 \
        x11-xkb-utils \
        xauth \
        xfonts-base \
        xkb-data \
    && apt-get autoclean \
    && apt-get autoremove 

RUN useradd --create-home --groups sudo --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}

# Clone noVNC.
RUN git clone https://github.com/novnc/noVNC.git $HOME/noVNC

# Clone websockify for noVNC
RUN git clone https://github.com/kanaka/websockify $HOME/noVNC/utils/websockify

# Copy supervisor config.
COPY supervisor.conf /etc/supervisor/conf.d/

# Copy startup script.
COPY startup.sh $HOME

CMD ["/bin/bash", "/home/markus/startup.sh"]