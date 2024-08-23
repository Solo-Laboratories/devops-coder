from debian:trixie-slim

RUN apt update \
 && apt upgrade -y \
 && apt install -y sudo clang-18 clang++-18 lldb cmake meson ninja-build make git clang-tidy clang-format valgrind python3 python3-pip python-is-python3 --no-install-recommends \
 && apt clean autoclean \
 && apt autoremove -y \
 && rm -rf /var/lib/apt/lists/* \
 && python -m pip install conan==2.6

ARG USER=chris
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}

