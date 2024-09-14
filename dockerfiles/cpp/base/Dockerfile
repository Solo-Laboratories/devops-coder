FROM docker.io/sololaboratories/base:debian

RUN apt update \
 && apt upgrade -y \
 && apt install -y cmake meson ninja-build make valgrind --no-install-recommends \
&& apt clean autoclean \
&& apt autoremove -y \
&& rm -rf /var/lib/apt/lists/* 