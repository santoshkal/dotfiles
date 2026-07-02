# Dotfiles

Managed with [chezmoi](https://chezmoi.io).

## Bootstrap a new machine

```sh
sh -c "$(wget -qO- https://raw.githubusercontent.com/santoshkal/dotfiles/chezmoi-new/scripts/install_dotfiles.sh)"
```

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


