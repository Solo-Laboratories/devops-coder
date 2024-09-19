set -e

# Install Kompose if not present
if [ ! -f $PWD/kompose ]; then
  echo "Downloading Kompose..."
  curl -L https://github.com/kubernetes/kompose/releases/download/v1.34.0/kompose-linux-amd64 -o kompose
fi

echo "Moving Kompose to /usr/local/bin..."
chmod +x $PWD/kompose
sudo mv $PWD/kompose /usr/local/bin/kompose