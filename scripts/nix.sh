set -e

if [ ! -f "~/.config/nix/nix.conf" ]; then
  echo "Updating nix.conf file...\n"
  mkdir -p ~/.config/nix
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  echo "store = local?store=~/.nix/store&state=~/.nix/state&log=~/.nix/log" >> ~/.config/nix/nix.conf
fi

if [ ! test -d "~/.nix" ]; then
  echo "Local Nix Store is not present...\n"
  mkdir -p ~/.nix/store
  mkdir -p ~/.nix/state
  mkdir -p ~/.nix/log
fi

echo "Installing or Updating Nix...\n"
curl -L https://nixos.org/nix/install | sh -s -- --no-daemon