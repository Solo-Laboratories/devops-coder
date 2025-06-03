FROM alpine:3.22
ARG USER=coder
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apk add curl xz sudo bash git direnv

RUN adduser -M -s /bin/bash -u $USER_UID $USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

USER $USER
RUN sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon

ENV PATH="${PATH}:/home/$USER/.local/state/nix/profiles/profile/bin/"
RUN echo 'eval "$(direnv hook bash)"' >> /etc/skel/.bashrc