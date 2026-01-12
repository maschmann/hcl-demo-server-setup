# HCL Demo Server Deployment

This repository contains an Ansible playbook and a Makefile wrapper to automate the deployment of the HCL Demo Server to a Raspberry Pi (or similar Debian-based system).

## What this setup does

*   Connects to a target machine (default: `raspberrypi.local`).
*   Installs **OpenJDK 21**.
*   Creates a dedicated system user `hcl-demo`.
*   Sets up the required directory structure under `/opt/hcl-demo-server/lox-testdata` (office, bedroom, livingroom, kitchen).
*   Fetches the **latest release JAR** from the private GitHub repository `maschmann/hcl-demo-server`.
*   Installs and starts a **systemd service** (`hcl-demo-server`) to run the application.

## Prerequisites

1.  **Ansible**: Ensure Ansible is installed on your local machine.
2.  **Make**: Ensure `make` is installed.
3.  **SSH Access**: You must have SSH access to the target Raspberry Pi.
4.  **GitHub Token**: Since the repository is private, you need a GitHub Personal Access Token (PAT) with `repo` scope to download the release asset.

## Usage

The `Makefile` simplifies the Ansible execution.

### Basic Usage

Run the following command to deploy to `raspberrypi.local` as user `pi`:

```bash
make install TOKEN=your_github_pat_here
```

### Custom Host or User

If your Raspberry Pi has a different IP address or username:

```bash
make install TOKEN=your_github_pat_here HOST=192.168.1.100 USER=admin
```

### Handling Sudo Passwords

If the target user requires a password for `sudo` (to install packages, etc.), add the `FLAGS=-K` argument. This will prompt you for the BECOME password:

```bash
make install TOKEN=your_github_pat_here FLAGS=-K
```

## Directory Structure

The deployment creates the following structure on the target:

```
/opt/hcl-demo-server/
├── app.jar                  # The latest application binary
└── lox-testdata/           # Data directory
    ├── bedroom/
    ├── kitchen/
    ├── livingroom/
    └── office/
```

## Service Management

After deployment, the service is automatically started. You can manage it on the Raspberry Pi with standard systemd commands:

```bash
# Check status
systemctl status hcl-demo-server

# Restart service
sudo systemctl restart hcl-demo-server

# View logs
journalctl -u hcl-demo-server -f
```
