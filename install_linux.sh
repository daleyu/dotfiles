#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -f /etc/arch-release ]]; then
  echo "This installer targets Arch Linux (pacman + yay)." >&2
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "pacman was not found; this does not look like an Arch system." >&2
  exit 1
fi

sudo pacman -Syu --needed --noconfirm base-devel git

if ! command -v yay >/dev/null 2>&1; then
  AUR_BUILD_DIR="$(mktemp -d "${TMPDIR:-/tmp}/yay-bin.XXXXXX")"
  git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$AUR_BUILD_DIR/yay-bin"
  (
    cd "$AUR_BUILD_DIR/yay-bin"
    makepkg -si --noconfirm
  )
fi

mapfile -t ARCH_PACKAGES < <(sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' "$DOTFILES_DIR/arch.txt")
if ((${#ARCH_PACKAGES[@]})); then
  yay -S --needed --noconfirm "${ARCH_PACKAGES[@]}"
fi

STOW_PACKAGES=(
  alacritty bat delta fontconfig ghostty git herdr hypr lazygit linux mise
  nvim rofi rg spicetify tmux waybar yazi zsh
)
stow --restow --target="$HOME" --ignore='^Library/' "${STOW_PACKAGES[@]}"

if command -v mise >/dev/null 2>&1; then
  mise install
  eval "$(mise activate bash)"
  # shellcheck source=utils.sh
  source "$DOTFILES_DIR/utils.sh"
  install_herdr
else
  echo "mise was not installed; skipping mise tools and Herdr plugins." >&2
fi
