# Dotfiles

Managed with [chezmoi](https://chezmoi.io).

## Quick start (new machine)

This single command is all you need on a fresh Ubuntu or Arch system:

```sh
sh -c "$(wget -qO- https://raw.githubusercontent.com/santoshkal/dotfiles/chezmoi-new/scripts/install_dotfiles.sh)"
```

It installs git, clones the repo, installs chezmoi, and applies all dotfiles — fully automated, OS-detecting (Arch/Ubuntu).

## Usage

| Action | Command |
|---|---|
| Pull latest dotfiles from GitHub | `chezmoi update` |
| Preview changes before applying | `chezmoi diff` |
| Add a new dotfile to management | `chezmoi add ~/.somefile` |
| Edit a managed file directly | `chezmoi edit ~/.somefile` |
| Manually re-apply all dotfiles | `chezmoi apply` |
| Commit and push changes | `cd $(chezmoi source-path) && git add -A && git commit -m "..." && git push` |

## Structure

| Path | Purpose |
|---|---|
| `install.sh` | Installs chezmoi, runs `chezmoi init --apply` |
| `scripts/install_dotfiles.sh` | Convenience script — installs git, clones repo, runs `install.sh` |
| `home/` | Chezmoi source root (via `.chezmoiroot`) |
| `home/.chezmoi.yaml.tmpl` | Chezmoi config — OS detection (Arch/Ubuntu), interactive name/email prompts |
| `home/.chezmoiscripts/` | Scripts run before/after dotfiles are applied |
| `home/.chezmoitemplates/` | Reusable template snippets |
| `home/.chezmoiexternal.yaml` | External downloads (fonts, etc.) |
| `home/dot_*` | `~/.` files (zshrc, tmux.conf, gitconfig, profile, bashrc) |
| `home/dot_config/` | `~/.config/*` (nvim, ghostty, i3, kitty, lazygit, tmuxinator, yazi) |
| `home/dot_local/bin/` | `~/.local/bin/*` (helper scripts) |

## Application order

1. `run_before_*` — install essentials (git, zsh, curl, yay)
2. All dotfiles land in `~/`
3. `run_after_*` — install packages, configure shell (oh-my-zsh, p10k, plugins), configure nvim (lazy.nvim, tpm)

OS detection in `.chezmoi.yaml.tmpl` reads `/etc/os-release` and sets `is_arch`/`is_ubuntu` — all scripts use these conditionals for the right package manager.


