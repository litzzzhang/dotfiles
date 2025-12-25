#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

# Targets
NVIM_TARGET="$HOME/.config/nvim"
GITCONFIG_TARGET="$HOME/.gitconfig"

# Sources inside repo
NVIM_SOURCE="$DOTFILES/nvim"
# 推荐你在仓库根目录新建一个 gitconfig 文件
GITCONFIG_SOURCE="$DOTFILES/gitconfig"

# make sure ~/.config exists
mkdir -p "$HOME/.config"

# ---- nvim ----
if [ -e "$NVIM_TARGET" ] || [ -L "$NVIM_TARGET" ]; then
  echo "Removing existing nvim config at $NVIM_TARGET"
  rm -rf "$NVIM_TARGET"
fi

ln -s "$NVIM_SOURCE" "$NVIM_TARGET"

# ---- gitconfig ----
if [ -f "$GITCONFIG_SOURCE" ]; then
  # 如果 ~/.gitconfig 已存在（文件或软链），先备份再替换
  if [ -e "$GITCONFIG_TARGET" ] || [ -L "$GITCONFIG_TARGET" ]; then
    BACKUP="$GITCONFIG_TARGET.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing gitconfig: $GITCONFIG_TARGET -> $BACKUP"
    mv "$GITCONFIG_TARGET" "$BACKUP"
  fi

  ln -s "$GITCONFIG_SOURCE" "$GITCONFIG_TARGET"
  echo "gitconfig -> $GITCONFIG_SOURCE"
else
  echo "Warning: $GITCONFIG_SOURCE not found, skipping gitconfig setup."
  echo "Tip: create $GITCONFIG_SOURCE in your repo root."
fi

echo "Dotfiles installed successfully"
echo "nvim -> $NVIM_SOURCE"

