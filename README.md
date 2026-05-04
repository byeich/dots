# dots

Personal dotfiles and scripts.

## Install

```bash
git clone https://github.com/byeich/dots.git ~/dots
cd ~/dots
./install.sh
```

On macOS (zsh):
```bash
source ~/.zshrc
```

On Linux/WSL (bash):
```bash
source ~/.bashrc
```

`install.sh` symlinks `.zshrc`, `.bashrc`, and `.gitconfig` into `$HOME`.

## What's included

| File | Description |
|------|-------------|
| `zsh/.zshrc` | Aliases, prompt, zsh completion (macOS) |
| `bash/.bashrc` | Same config for bash (Linux/WSL) |
| `git/.gitconfig` | Git user config and aliases |
| `scripts/truenas-pre-upgrade.sh` | Pre-upgrade checks for TrueNAS (run via SSH) |

## Scripts

### `truenas-pre-upgrade.sh`

Run on TrueNAS before any system upgrade. Checks pool health, blocks if a scrub is running, runs SMART checks, snapshots the tank dataset, and reminds you to stop apps.

```bash
ssh truenas 'bash -s' < scripts/truenas-pre-upgrade.sh
```
