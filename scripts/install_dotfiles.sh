#!/bin/sh
set -eu

log_color() { color_code="$1"; shift; printf "\033[${color_code}m%s\033[0m\n" "$*" >&2; }
log_red()   { log_color "0;31" "$@"; }
log_blue()  { log_color "0;34" "$@"; }
log_task()  { log_blue " %s" "$@"; }
log_error() { log_red " %s" "$@"; }
error()     { log_error "$@"; exit 1; }

sudo() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    if ! command sudo --non-interactive true 2>/dev/null; then
      sudo --validate
    fi
    command sudo "$@"
  fi
}

DOTFILES_REPO_HOST=${DOTFILES_REPO_HOST:-"https://github.com"}
DOTFILES_USER=${DOTFILES_USER:-"santoshkal"}
DOTFILES_REPO="${DOTFILES_REPO_HOST}/${DOTFILES_USER}/dotfiles"
DOTFILES_BRANCH=${DOTFILES_BRANCH:-"chezmoi-new"}
DOTFILES_DIR="${HOME}/.dotfiles"

if ! command -v git >/dev/null 2>&1; then
  log_task "Installing git"
  if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo env DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends git
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm git
  fi
fi

if [ -d "${DOTFILES_DIR}" ]; then
  log_task "Removing stale '${DOTFILES_DIR}' and cloning fresh"
  rm -rf "${DOTFILES_DIR}"
fi

log_task "Cloning '${DOTFILES_REPO}' at branch '${DOTFILES_BRANCH}' to '${DOTFILES_DIR}'"
git clone --branch "${DOTFILES_BRANCH}" "${DOTFILES_REPO}" "${DOTFILES_DIR}"

if [ -f "${DOTFILES_DIR}/install.sh" ]; then
  INSTALL_SCRIPT="${DOTFILES_DIR}/install.sh"
else
  error "No install script found in the dotfiles."
fi

log_task "Running '${INSTALL_SCRIPT}'"
exec "${INSTALL_SCRIPT}" "$@"
