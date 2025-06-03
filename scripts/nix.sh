set -e

if [ ! -f "/home/coder/.config/nix/nix.conf" ]; then
  echo "Updating nix.conf file..."
  mkdir -p /home/coder/.config/nix
  echo "experimental-features = nix-command flakes" >> /home/coder/.config/nix/nix.conf
  echo "store = local?store=/home/coder/.nix/store&state=/home/coder/.nix/state&log=/home/coder/.nix/log" >> /home/coder/.config/nix/nix.conf
fi

if [ ! -d "/home/coder/.nix" ]; then
  echo "Local Nix Store is not present..."
  mkdir -p /home/coder/.nix/store /home/coder/.nix/state /home/coder/.nix/log
fi

echo "Installing or Updating Nix..."
curl -L https://nixos.org/nix/install | sh -s -- --no-daemon