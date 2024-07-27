FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends git wget sudo ca-certificates

RUN wget https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.620+eab934814.tar.xz \
    && tar -xvf zig-linux-x86_64-0.14.0-dev.620+eab934814.tar.xz \
    && ln -s `pwd`/zig-linux-x86_64-0.14.0-dev.620+eab934814/zig /bin/zig \
    && chmod ugo+x /bin/zig \
    && zig version

ARG USER=markus
RUN useradd --groups sudo --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}