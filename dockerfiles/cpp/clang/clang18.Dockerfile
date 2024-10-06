FROM docker.io/sololaboratories/cpp:base

RUN apt update && apt upgrade -y && \
    apt install -y clang-18 lldb clang-tidy clang-format --no-install-recommends && \
    apt clean autoclean && apt autoremove -y && rm -rf /var/lib/apt/lists/* && pip install conan && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100 

USER coder
WORKDIR /home/coder