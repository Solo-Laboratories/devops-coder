FROM docker.io/sololaboratories/base:debian-trixie

RUN apt update \
    && apt upgrade -y \
    && apt install -y cmake meson ninja-build make valgrind --no-install-recommends \
    && pip install conan \
    && apt clean autoclean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/* 