FROM docker.io/sololaboratories/base:debian-trixie
ARG ZIG_VERSION=x86_64-0.14.0-dev.2568+42dac40b3

RUN wget https://ziglang.org/builds/zig-linux-${ZIG_VERSION}.tar.xz \
    && tar -xvf zig-linux-${ZIG_VERSION}.tar.xz \
    && rm -f zig-linux-${ZIG_VERSION}.tar.xz \
    && ln -s `pwd`/zig-linux-${ZIG_VERSION}/zig /bin/zig \
    && chmod ugo+x /bin/zig \
    && zig version

USER coder