FROM alpine:3.20

RUN apk update && apk upgrade && apk add --no-cache zig curl git

# Set user and group
RUN     apk add doas; \
        adduser markus -G wheel; \
        echo 'permit nopass :wheel as root' > /etc/doas.d/doas.conf

# Switch to user
USER markus