set -e

# Configure Kubectl IF the file is here
if [ -f $HOME/.kube/config ]; then
    echo "Changing .kube/config to remove write permissions..."
    chmod go-r $HOME/.kube/config
fi