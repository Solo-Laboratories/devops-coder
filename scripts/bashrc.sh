set -e

# Check that .bashrc is present
if [ ! -f ~/.bashrc ]; then
    echo ".bashrc is missing. Copying from system files..."
    cp /etc/skel/.bashrc ~/
fi