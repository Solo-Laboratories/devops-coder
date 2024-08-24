from debian:trixie-slim

RUN apt update \
 && apt upgrade -y \
 && apt install -y gcc g++ gdb cmake meson ninja-build make clang-tidy clang-format valgrind \
                git neovim \
                man sudo wget \
                python3 python3-pip python-is-python3 \
                --no-install-recommends \
 && apt clean autoclean \
 && apt autoremove -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm /usr/lib/python*/EXTERNALLY-MANAGED \
 && python -m pip install conan

COPY ./cpp-builder-gcc14.Dockerfile /cpp-builder-gcc14.Dockerfile

ARG USER=chris
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}

