#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

NVIM_TARGET="$HOME/.config/nvim"

# make sure ~/.config exists
mkdir -p "$HOME/.config"

if [ -e "$NVIM_TARGET" ] || [ -L "$NVIM_TARGET" ]; then
  echo "Removing existing nvim config at $NVIM_TARGET"
  rm -rf "$NVIM_TARGET"
fi

ln -s "$DOTFILES/nvim" "$NVIM_TARGET"

echo "Dotfiles installed successfully"
echo "nvim -> $DOTFILES/nvim"

