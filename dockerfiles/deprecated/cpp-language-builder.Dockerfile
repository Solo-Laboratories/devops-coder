FROM ubuntu:22.04

ARG GLAB_VERSION=1.40.0

RUN apt-get update && apt-get install curl sudo wget ca-certificates git valgrind clang-13 clang-format-13 clang-tidy-13 cmake make ninja-build llvm-13 llvm-13-dev llvm-13-tools llvm-13-examples python3 python3-pip -y --no-install-recommends

RUN rm -rf /var/lib/apt/lists/* && pip install conan && \
	update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 100 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 100 && \
	update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-13 100 && \
	update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-13 100 && \
	update-alternatives --install /usr/bin/llvm-cov llvm-cov /usr/bin/llvm-cov-13 100 

RUN wget https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_Linux_x86_64.deb && dpkg -i glab_${GLAB_VERSION}_Linux_x86_64.deb && rm -f glab_${GLAB_VERSION}_Linux_x86_64.deb

ARG USER=markus
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}
