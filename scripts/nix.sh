set -e

if command -v nix &> /dev/null; then
  echo "Nix Package Manager Found!"
else
  echo "Nix Package Manager not found. Installing Nix...\n"
  curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
fi