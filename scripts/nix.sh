set -e

if command -v application_name &> /dev/null; then
  echo "Nix Package Manager Found!"
else
  echo "Nix Package Manager not found. Installing Nix...\n"
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
fi