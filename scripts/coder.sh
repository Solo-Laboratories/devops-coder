set -e

# Install Coder
curl -fsSL https://coder.com/install.sh | sh -s -- --stable

if ! coder list > /dev/null 2>&1; then
  set +x
  coder login --token="${CODER_USER_TOKEN}" --url="${CODER_DEPLOYMENT_URL}"
else
  echo "You are already authenticated with coder."
fi