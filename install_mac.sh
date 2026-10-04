#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer targets macOS." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew bundle --file="$DOTFILES_DIR/Brewfile"

STOW_PACKAGES=(
  aerospace alacritty bat delta fish fontconfig ghostty git herdr iterm
  jankyborders karabiner lazygit mise nvim rg sketchybar spicetify tmux vim
  yazi zsh
)
stow --restow --target="$HOME" "${STOW_PACKAGES[@]}"

if command -v mise >/dev/null 2>&1; then
  mise install
  eval "$(mise activate bash)"
  # shellcheck source=utils.sh
  source "$DOTFILES_DIR/utils.sh"
  install_herdr
else
  echo "mise was not installed; skipping mise tools and Herdr plugins." >&2
fi
