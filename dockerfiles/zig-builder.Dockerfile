FROM alpine:3.20

RUN apk add --no-cache zig

# Set user and group
ARG user=markus
ARG group=markus
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/sh -m ${user}

# Switch to user
USER ${uid}:${gid}