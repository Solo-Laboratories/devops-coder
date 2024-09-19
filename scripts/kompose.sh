set -e

# Install Kompose if not present
if [ ! -f $PWD/kompose ]; then
  echo "Downloading Kompose..."
  curl -L https://github.com/kubernetes/kompose/releases/download/v1.34.0/kompose-linux-amd64 -o kompose
fi

#Check to see if exists .. If not append
if ! grep -q "export PATH='$PATH:$PWD/kompose'" "$HOME/.bashrc"; then
  echo "Updating PATH in ~/.bashrc for kompose..."
  echo "\n# Kompose Executable Added to PATH" >> $HOME/.bashrc;
  echo "export PATH='$PATH:$PWD/kompose'" >> $HOME/.bashrc;
fi