set -e

# install and start code-server
curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/tmp/code-server --version 4.11.0
/tmp/code-server/bin/code-server --auth none --port 13337 >/tmp/code-server.log 2>&1 &