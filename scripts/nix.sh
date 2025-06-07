set -e

if command -v nix &> /dev/null; then
    echo "Nix found. To update please use 'curl -L https://nixos.org/nix/install | sh -s -- --no-daemon'"
else
    echo "Installing or Updating Nix..."
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
fi