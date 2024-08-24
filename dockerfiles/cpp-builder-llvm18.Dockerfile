from debian:trixie-slim

RUN apt update \
 && apt upgrade -y \
 && apt install -y sudo clang-18 lldb cmake meson ninja-build make git clang-tidy clang-format valgrind \
                git neovim \
                man sudo wget \
                python3 python3-pip python-is-python3 \
                --no-install-recommends \
 && apt clean autoclean \
 && apt autoremove -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm /usr/lib/python*/EXTERNALLY-MANAGED \
 && python -m pip install conan

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-18 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-18 100

COPY ./cpp-builder-llvm18.Dockerfile /cpp-builder-llvm18.Dockerfile

ARG USER=chris
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}

