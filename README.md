# Dotfiles

These are the dotfiles that I use and live by. Perhaps you will find them useful too!

To install on Linux and MacOS (still a work in progress):

```sh
git clone https://github.com/jeremyckahn/dotfiles.git ~/dotfiles
. ~/dotfiles/install.sh
```

## Llama Server (Linux)

This dotfiles repo includes optional configuration for a llama.cpp server running as a systemd service.

**Prerequisite:** Clone llama.cpp to `~/oss/llama.cpp`:

```sh
git clone https://github.com/ggml-org/llama.cpp ~/oss/llama.cpp
```

### Files Included

- `llama/llama.ini` - Model presets for llama-server
- `llama/scripts/update-llama.sh` - Build and deploy script for llama.cpp updates
- `llama/etc/systemd/system/llama-server.service` - Systemd service unit

### Setup

1. Install build dependencies (one-time):

   ```sh
   make llama.dependencies
   ```

2. Clone llama.cpp (if not already done):

   ```sh
   git clone https://github.com/ggml-org/llama.cpp ~/oss/llama.cpp
   ```

3. Install the llama dotfiles (opt-in):

   ```sh
   make llama
   ```

4. Enable the systemd service:

   ```sh
   sudo make llama.setup
   ```

5. View service status:

   ```sh
   sudo systemctl status llama-server
   ```

6. View logs:

   ```sh
   sudo journalctl -u llama-server -f
   ```

### Updating llama.cpp

Run the update script to pull the latest code, rebuild with Vulkan, and restart the service:

```sh
~/scripts/update-llama.sh
```
