FROM docker.io/sololaboratories/cpp:base
ARG CLANG_VERSION=18

COPY llvm.sh /
RUN apt update && apt upgrade -y && ./llvm.sh ${CLANG_VERSION} all && rm -f /llvm.sh &&
    apt clean autoclean && apt autoremove -y && rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100 

USER coder