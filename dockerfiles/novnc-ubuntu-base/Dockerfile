FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

# Install the Docker apt repository
RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes ca-certificates && \
    rm -rf /var/lib/apt/lists/*
COPY docker-archive-keyring.gpg /usr/share/keyrings/docker-archive-keyring.gpg
COPY docker.list /etc/apt/sources.list.d/docker.list

# Install baseline packages
RUN apt-get update && \
    apt-get install --yes \
    bash \
    build-essential \
    ca-certificates \
    containerd.io \
    curl \
    docker-ce \
    docker-ce-cli \
    docker-buildx-plugin \
    docker-compose-plugin \
    htop \
    jq \
    locales \
    man \
    python3 \
    python3-pip \
    software-properties-common \
    sudo \
    systemd \
    systemd-sysv \
    unzip \
    vim \
    wget \
    rsync && \
# Install latest Git using their official PPA
    add-apt-repository ppa:git-core/ppa && \
    apt-get install --yes git \
    && rm -rf /var/lib/apt/lists/*

# Enables Docker starting with systemd
RUN systemctl enable docker

# Create a symlink for standalone docker-compose usage
RUN ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/bin/docker-compose

# Make typing unicode characters in the terminal work.
ENV LANG=en_US.UTF-8

# Add a user `markus` so that you're not developing as the `root` user
RUN useradd markus \
    --create-home \
    --shell=/bin/bash \
    --groups=docker \
    --uid=1000 \
    --user-group && \
    echo "markus ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd

USER markus
USER 0

ARG DEBCONF_NONINTERACTIVE_SEEN=true
ARG DEBIAN_FRONTEND="noninteractive"
ARG TURBOVNC_VERSION=3.1
ARG VIRTUALGL_VERSION=3.1
ARG LIBJPEG_VERSION=3.0.1

RUN echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  zsh \
  supervisor \
  xorg \
  x11-apps \
  dbus-x11 \
  xterm \
  firefox \
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
  ubuntu-mate-desktop 

RUN pip3 install numpy

# Install quality of life packages.
RUN yes | unminimize


RUN locale-gen en_US.UTF-8

ARG HOME=/home/markus
ARG VNC_ROOT_DIR=/opt/vnc

RUN apt-get install libegl1-mesa 

RUN cd /tmp && \
    curl -fsSL -O https://downloads.sourceforge.net/project/libjpeg-turbo/${LIBJPEG_VERSION}/libjpeg-turbo-official_${LIBJPEG_VERSION}_amd64.deb \
    -O https://downloads.sourceforge.net/project/turbovnc/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb \
    -O https://downloads.sourceforge.net/project/virtualgl/${VIRTUALGL_VERSION}/virtualgl_${VIRTUALGL_VERSION}_amd64.deb \
    && dpkg -i *.deb \
    && rm -f /tmp/*.deb \
    && sed -i 's/$host:/unix:/g' /opt/TurboVNC/bin/vncserver

RUN ln -s /opt/TurboVNC/bin/* /opt/VirtualGL/bin/* /usr/local/bin/
# Configure VGL for use in a single user environment.
# This may trigger a warning about display managers needing to be restarted.
# This can be ignored as the VNC server manages this lifecycle.  
RUN vglserver_config -config +s +f +t

COPY turbovncserver-security.conf /etc/turbovncserver-security.conf

ENV VNC_SCRIPTS=$VNC_ROOT_DIR/scripts \
  VNC_SETUP_SCRIPTS=$VNC_ROOT_DIR/setup \
  VNC_LOG_DIR=$HOME/.vnc/log \
  VNC_XSTARTUP=$VNC_ROOT_DIR/xstartup \
  VNC_SUPERVISOR_CONFIG=$VNC_ROOT_DIR/supervisord.conf \
  VNC_PORT=5990 \
  VNC_DISPLAY_ID=:90 \
  VNC_COL_DEPTH=24 \
  VNC_RESOLUTION=3840x2160 \
  NO_VNC_HOME=$VNC_ROOT_DIR/noVNC \
  NO_VNC_PORT=6081 \
  XFCE_BASE_DIR=$VNC_ROOT_DIR/xfce4 \
  XFCE_DEST_DIR=$HOME/.config/xfce4

WORKDIR $HOME

# Enable better defaults for command tab completion.
RUN chsh -s $(readlink -f $(which zsh)) markus 

# ADD --chown=markus:markus ./xfce4 $XFCE_BASE_DIR
ADD --chown=markus:markus ./vnc $VNC_ROOT_DIR
ADD --chown=markus:markus ./supervisor /etc/supervisor

RUN find $VNC_SETUP_SCRIPTS -name '*.sh' -exec chmod a+x {} +

RUN $VNC_SETUP_SCRIPTS/set_user_permission.sh $VNC_ROOT_DIR \
  && chmod +x $VNC_XSTARTUP

# Add Coder-specific scripts and metadata to the image
COPY ["./coder", "/coder"]
RUN chmod +x /coder/configure

#COPY deprecated.txt /etc/motd
RUN echo '[ ! -z "$TERM" ] && cat /etc/motd' >> /etc/bash.bashrc

USER markus

RUN $VNC_SETUP_SCRIPTS/no_vnc.sh

# EXPOSE $NO_VNC_PORT





# # 
# # Pushed to DockerHub 2023-03-12 as marktmilligan/tigervnc:latest
# #
# # https://serverfault.com/questions/376302/tigervnc-ssh-without-a-vnc-password
# #

# # the base image 
# FROM marktmilligan/vnc:coder-v2

# USER root

# # Install baseline packages
# RUN apt-get update && \
#     DEBIAN_FRONTEND="noninteractive" apt-get install --yes \
#     mate-desktop-environment-extras

# COPY xstartup /coder/xstartup

# # # Modify to include my user
# # ARG USER=markus
# # RUN useradd --create-home --groups sudo --shell /bin/bash ${USER} \
# # 	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
# # 	&& chmod 0440 /etc/sudoers.d/${USER}
# # USER ${USER}
# # WORKDIR /home/${USER}