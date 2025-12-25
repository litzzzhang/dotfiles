#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
# ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

# if [ -f "$DOTFILES/shell/zshrc" ]; then
#   ln -sf "$DOTFILES/shell/zshrc" "$HOME/.zshrc"
# fi

echo "Dotfiles installed (Linux/macOS)"

