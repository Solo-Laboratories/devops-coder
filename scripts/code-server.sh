set -e

# $1 is code server version; for example "4.11.0"
# Default value for VERSION 
VAR="4.96.2" 
# Check if a parameter is passed 
if [ -z "$1" ]; then 
    VERSION=$VAR 
else 
    VERSION=$1 
fi

# install and start code-server
curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/tmp/code-server --version $VERSION
/tmp/code-server/bin/code-server --auth none --port 13337 >/tmp/code-server.log 2>&1 &
