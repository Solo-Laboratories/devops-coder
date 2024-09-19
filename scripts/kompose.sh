set -e

# Install Kompose
curl -L https://github.com/kubernetes/kompose/releases/download/v1.34.0/kompose-linux-amd64 -o kompose

#Check to see if exists .. If not append
if ! grep -q 'export PATH="$PATH:$PWD/kompose"' "$HOME/.bashrc"; then
  echo "# Kompose Executable Added to PATH" >> $HOME/.bashrc;
  echo 'export PATH="$PATH:$PWD/kompose"' >> $HOME/.bashrc;
fi