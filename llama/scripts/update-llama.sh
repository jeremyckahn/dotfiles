#!/bin/bash

# https://gemini.google.com/app/8baad60930d6cdd7

# Exit immediately if a command exits with a non-zero status
set -e

REPO_DIR="$HOME/oss/llama.cpp"
OPT_DIR="/opt/llama.cpp/bin"
SERVICE_NAME="llama-server"

echo "=== Pulling latest llama.cpp code ==="
cd "$REPO_DIR"
git pull

echo "=== Building with Vulkan ==="
rm -rf build
cmake -B build -DGGML_VULKAN=ON -DGGML_CCACHE=ON
cmake --build build --config Release -j

echo "=== Deploying binary to $OPT_DIR ==="
sudo systemctl stop "$SERVICE_NAME"
# CMake usually places the binary in the build/bin directory
sudo cp build/bin/* "$OPT_DIR/"

echo "=== Restarting $SERVICE_NAME service ==="
# Reload systemd just in case you manually edited the .service file recently
sudo systemctl daemon-reload
sudo systemctl restart "$SERVICE_NAME"

echo "=== Deployment Complete! ==="
# Show the status of the service to verify it started correctly
sudo systemctl status "$SERVICE_NAME" --no-pager | head -n 12

echo "view logs with:"
echo "  sudo journalctl -u llama-server -f"
