FROM docker.io/sololaboratories/base:debian-trixie
ARG ZIG_VERSION=x86_64-0.14.0-dev.2568+42dac40b3

RUN wget https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.1694+3b465ebec.tar.xz \
    && tar -xvf zig-linux-x86_64-0.14.0-dev.1694+3b465ebec.tar.xz \
    && rm -f zig-linux-x86_64-0.14.0-dev.1694+3b465ebec.tar.xz \
    && ln -s `pwd`/zig-linux-x86_64-0.14.0-dev.1694+3b465ebec/zig /bin/zig \
    && chmod ugo+x /bin/zig \
    && zig version

USER coder