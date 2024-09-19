set -e

# $1 is kompose version; for example "1.34.0"

# Install Kompose if not present
if [ ! -f $PWD/kompose ]; then
  echo "Downloading Kompose..."
  curl -L https://github.com/kubernetes/kompose/releases/download/v${1}/kompose-linux-amd64 -o kompose
fi

echo "\nMoving Kompose to /usr/local/bin..."
chmod +x $PWD/kompose
sudo cp $PWD/kompose /usr/local/bin/kompose