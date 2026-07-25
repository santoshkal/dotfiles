#!/bin/bash
set -euo pipefail

SERVICES="waybar dunst hyprpaper hypridle hyprpolkitagent"
SDIR="$HOME/.config/systemd/user"

mkdir -p "$SDIR"

# Copy custom service files bundled alongside this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
for f in waybar.service dunst.service; do
  if [ -f "$SCRIPT_DIR/systemd/$f" ]; then
    cp "$SCRIPT_DIR/systemd/$f" "$SDIR/$f"
  fi
done

systemctl --user daemon-reload

for s in $SERVICES; do
  echo "Enabling and starting $s ..."
  systemctl --user enable --now "$s" 2>&1 || true
done

echo "Done. Check status with: systemctl --user status $SERVICES"
