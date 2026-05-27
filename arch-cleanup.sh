#!/bin/bash

set -euo pipefail

cleanup() {
  echo "=== 1/8  Pacman ==="
  sudo pacman -Syu
  sudo paccache -r
  orphans=$(pacman -Qdtq)
  if [[ -n "$orphans" ]]; then
    sudo pacman -Rns $orphans
  fi
  echo

  echo "=== 2/8  Docker ==="
  if command -v docker &>/dev/null; then
    echo "Pruning all unused Docker objects..."
    sudo docker system prune -a --volumes -f
    sudo docker builder prune -a -f
  else
    echo "Docker not installed — skipping"
  fi
  echo

  echo "=== 3/8  Journal (logs older than 7 days) ==="
  sudo journalctl --vacuum-time=1d 2>/dev/null || echo "No journald logs to clean"
  echo

  echo "=== 4/8  npm / yarn cache ==="
  if [[ -d "$HOME/.npm/_cacache" ]]; then
    rm -rf "$HOME/.npm/_cacache"
    echo "npm cache cleared"
  else
    echo "No npm cache found"
  fi
  if [[ -d "$HOME/.cache/yarn" ]]; then
    rm -rf "$HOME/.cache/yarn"
    echo "yarn cache cleared"
  else
    echo "No yarn cache found"
  fi
  echo

  echo "=== 5/8  pip cache ==="
  if command -v pip &>/dev/null; then
    pip cache purge 2>/dev/null || echo "No pip cache to purge"
  else
    echo "pip not installed — skipping"
  fi
  echo

  echo "=== 6/8  Flatpak (unused runtimes) ==="
  if command -v flatpak &>/dev/null; then
    flatpak uninstall --unused -y 2>/dev/null || echo "No unused flatpaks"
  else
    echo "Flatpak not installed — skipping"
  fi
  echo

  echo "=== 7/8  Snap (old disabled revisions) ==="
  if command -v snap &>/dev/null; then
    snap list --all 2>/dev/null | awk '/disabled/{print $1, $3}' | while read -r snap_name snap_rev; do
      sudo snap remove "$snap_name" --revision="$snap_rev" 2>/dev/null
    done
    echo "Old snap revisions cleaned"
  else
    echo "Snap not installed — skipping"
  fi
  echo

  echo "=== 8/8  Largest orphaned packages (informational) ==="
  if command -v expac &>/dev/null; then
    echo "Top-10 biggest installed packages:"
    expac -H M '%m\t%n' | sort -rh | head -10
  else
    echo "Install expac (pacman -S expac) to see largest packages"
  fi
  echo

  echo "=== ~/.cache summary ==="
  du -sh "$HOME/.cache" 2>/dev/null && echo "Uncomment the rm line in the script to clear this"
  # rm -rf "$HOME/.cache/"* 2>/dev/null || true
  echo

  echo "=== All done! ==="
}

# Run it
cleanup
