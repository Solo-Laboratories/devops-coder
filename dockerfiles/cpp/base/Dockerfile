FROM docker.io/sololaboratories/base:debian-bookworm

RUN apt update \
    && apt upgrade -y \
    && apt install -y cmake meson ninja-build make valgrind --no-install-recommends \
    && pip install conan --ignore-installed

RUN apt autoremove -y \
    && apt clean autoclean \
    && rm -rf /var/lib/apt/lists/* 