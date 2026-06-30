# chezmoi migration

This directory contains chezmoi reference config files. When you're ready to
migrate from stow to chezmoi, follow these steps:

## Migration steps

```bash
# 1. Install chezmoi
sudo pacman -S chezmoi

# 2. Init chezmoi with an empty source dir (sets up ~/.local/share/chezmoi/)
chezmoi init

# 3. Add all your existing dotfiles
chezmoi add ~/.zshrc
chezmoi add ~/.gitconfig
chezmoi add ~/.p10k.zsh
chezmoi add ~/.tmux.conf
chezmoi add ~/.config/nvim
chezmoi add ~/.config/i3
chezmoi add ~/.config/i3blocks
chezmoi add ~/.config/kitty
chezmoi add ~/.config/lazygit
chezmoi add ~/.config/tmuxinator
chezmoi add ~/.config/yazi
chezmoi add ~/.config/ghostty
chezmoi add ~/.config/zathura
chezmoi add ~/.config/btop
chezmoi add ~/.config/fontconfig
chezmoi add ~/.config/autostart
chezmoi add ~/.config/flameshot

# 4. Copy the chezmoi reference files into the source directory
cp -r ~/dotfiles/chezmoi/.chezmoidata ~/.local/share/chezmoi/
cp ~/dotfiles/chezmoi/.chezmoi.yaml.tmpl ~/.local/share/chezmoi/
cp ~/dotfiles/chezmoi/run_onchange_after_arch-install-packages.sh.tmpl ~/.local/share/chezmoi/

# 5. Regenerate config from template (will ask for your email)
chezmoi init

# 6. Preview what will change
chezmoi diff

# 7. Apply
chezmoi apply

# 8. Remove stow-managed symlinks (chezmoi now owns the files directly)
# (stow will error on conflicts — remove symlinks manually or use stow -D)
cd ~/dotfiles && stow -D .

# 9. Set up remote (uses the same repo URL as before)
chezmoi cd
git remote add origin <your-repo-url>
git add -A
git commit -m "migrate from stow to chezmoi"
git push -u origin main

# 10. Clean up old stow repo (optional, once migration is verified)
# rm -rf ~/dotfiles
```

## Daily workflow

```bash
chezmoi edit ~/.zshrc      # edit a managed file
chezmoi diff                # preview changes
chezmoi apply               # apply changes
chezmoi cd                  # open shell in source dir (for git cmds)
chezmoi update              # pull remote + apply
```

---

## Managing packages (add/remove)

### How it works

Packages are declared in `.chezmoidata/packages.yaml`. The
`run_onchange_after_*` script is a **template** (`.sh.tmpl`) that chezmoi
renders with that data. chezmoi tracks a content hash of the rendered script
— the script only executes when the hash changes (i.e. when the package list
changes).

### Adding a package

1. Edit `.chezmoidata/packages.yaml` and add the package name to the
   appropriate list (`official`, `aur`, or `fonts`).
2. Run `chezmoi apply`. The rendered script content changes, chezmoi
   re-executes it, and `pacman -S --needed` installs the new package
   (idempotent — existing packages are skipped).

### Removing a package

1. Remove the package name from `.chezmoidata/packages.yaml`.
2. Run `chezmoi apply` — this updates the script hash but the script
   does **not** auto-uninstall packages (shell scripts are imperative).
3. Manually uninstall on each machine:
   ```bash
   sudo pacman -Rs <package-name>
   ```

### Why no auto-remove?

`run_onchange_*` scripts run **forward** — they install what's in the list.
chezmoi has no mechanism to diff the declared list against what's actually
installed and uninstall the delta. If you want that, add explicit removal
commands to the script (e.g. `pacman -Rs --noconfirm` for packages no longer
in the list), but this is risky and not recommended for declarative setup.

---

## Using on Ubuntu (or other Debian-based)

The current config is Arch-specific (uses `pacman`, `yay`, Arch package names).
To support Ubuntu, you need two changes.

### 1. Package data — split by OS

**`.chezmoidata/packages.yaml`:**

```yaml
packages:
  arch:
    official:
      - neovim
      - fzf
      - bat
      ...
    aur:
      - tmuxinator
      ...
  ubuntu:
    apt:
      - neovim
      - fzf
      - batcat
      - fd-find
      - ripgrep
      - btop
      - flameshot
      - jq
      - docker.io
      - docker-compose-v2
      - golang-go
      - pass
      - openssh-client
      - curl
      - wget
```

Note name differences: `bat` → `batcat`, `fd` → `fd-find`,
`docker` → `docker.io`, `eza` → not in apt (needs cargo or ppa),
`ghostty` → not in apt (needs snap or build from source),
`git-delta` → `git-delta` (in universe), `github-cli` → `gh` (in apt).

### 2. Script — use OS conditions

**`run_onchange_after_install-packages.sh.tmpl`:**

```bash
#!/bin/bash
set -euo pipefail

{{ if eq .chezmoi.osRelease.id "arch" -}}

sudo pacman -S --needed --noconfirm \
  {{ range .packages.arch.official -}} {{ . | quote }} \{{ end }}
  {{ range .packages.arch.fonts -}} {{ . | quote }} \{{ end }}
  ;

{{ if command -v yay &>/dev/null; then -}}
yay -S --needed --noconfirm \
  {{ range .packages.arch.aur -}} {{ . | quote }} \{{ end }}
  ;
{{ end -}}

{{ else if eq .chezmoi.osRelease.id "ubuntu" -}}

sudo apt update
sudo apt install -y \
  {{ range .packages.ubuntu.apt -}} {{ . | quote }} \{{ end }}
  ;

{{ end -}}
```

chezmoi's `.chezmoi.osRelease.id` is available on Linux systems
(returns `"arch"`, `"ubuntu"`, `"fedora"`, etc.).
On a new Ubuntu machine, `chezmoi init --apply` will:
- detect `ubuntu` via `.chezmoi.osRelease.id`
- render the `ubuntu` branch of the script
- run `apt install` with the Ubuntu package names

### Important for cross-platform

Some tools are not in Ubuntu's repos or have different names — make sure
to verify each package name with `apt search <name>` before adding it.
