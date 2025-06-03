FROM debian:trixie-slim
ARG USER=coder
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        curl sudo xz-utils git direnv ca-certificates wget lsb-release jq openssh-client software-properties-common apt-transport-https && \
    apt clean autoclean && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*
    
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}

RUN echo 'eval "$(direnv hook bash)"' >> /etc/skel/.bashrc

USER $USER
