set -e

# $1 is code server version; for example "4.11.0"

# install and start code-server
curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/tmp/code-server --version $1
/tmp/code-server/bin/code-server --auth none --port 13337 >/tmp/code-server.log 2>&1 &