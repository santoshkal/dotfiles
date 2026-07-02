#!/bin/sh
set -eu

log_color() { color_code="$1"; shift; printf "\033[${color_code}m%s\033[0m\n" "$*" >&2; }
log_blue() { log_color "0;34" "$@"; }
log_task() { log_blue " %s" "$@"; }

log_task "Checking pre-requisites..."

if ! command -v git >/dev/null 2>&1; then
  log_task "Git is not installed. Will be installed during run_before_*."
fi

if ! command -v zsh >/dev/null 2>&1; then
  log_task "Zsh is not installed. Will be installed during run_before_*."
fi

log_task "Pre-requisites check complete."
