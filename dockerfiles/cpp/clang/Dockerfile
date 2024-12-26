FROM docker.io/sololaboratories/cpp:base
ARG CLANG_VERSION=18

RUN apt update && apt upgrade -y 

RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh ${CLANG_VERSION} all && rm -f /llvm.sh

RUN apt clean autoclean && apt autoremove -y && rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100 

USER coder