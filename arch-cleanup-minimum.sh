#!/bin/bash

set -euo pipefail

cleanup() {
  sudo pacman -Syu
  sudo paccache -r
  orphans=$(pacman -Qdtq)
  if [[ -n "$orphans" ]]; then
    sudo pacman -Rns $orphans
  fi
  echo "Cleaned-up"
}
