set -e

if [ ! -f "~/.config/nix/nix.conf" ]; then
  echo "Updating nix.conf file...\n"
  mkdir -p ~/.config/nix
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  echo "store = local?store=/home/coder/.nix/store&state=/home/coder/.nix/state&log=/home/coder/.nix/log" >> /home/coder/.config/nix/nix.conf
fi

if [ ! test -d "~/.nix" ]; then
  echo "Local Nix Store is not present...\n"
  mkdir -p /home/coder/.nix/store
  mkdir -p /home/coder/.nix/state
  mkdir -p /home/coder/.nix/log
fi

echo "Installing or Updating Nix...\n"
curl -L https://nixos.org/nix/install | sh -s -- --no-daemon