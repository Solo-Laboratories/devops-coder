set -e

# $1 is kompose version; for example "1.35.0"
# Default value for VERSION 
VAR="1.35.0" 
# Check if a parameter is passed 
if [ -z "$1" ]; then 
    VERSION=$VAR 
else 
    VERSION=$1 
fi

# Install Kompose if not present
if [ ! -f $PWD/kompose ]; then
  echo "\n\nDownloading Kompose..."
  curl -L https://github.com/kubernetes/kompose/releases/download/v${1}/kompose-linux-amd64 -o kompose
fi

echo "\nMoving Kompose to /usr/local/bin..."
chmod +x $PWD/kompose
sudo cp $PWD/kompose /usr/local/bin/kompose