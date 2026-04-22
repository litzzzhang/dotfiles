#!/usr/bin/env bash
set -euo pipefail

# 默认你的 dotfiles 仓库位置
DOTFILES_DIR="$HOME/dotfiles"

log() {
  printf '\033[1;32m[INFO]\033[0m %s\n' "$1"
}

warn() {
  printf '\033[1;33m[WARN]\033[0m %s\n' "$1"
}

backup_target() {
  local target="$1"

  if [ -e "$target" ] || [ -L "$target" ]; then
    local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    warn "备份已有文件: $target -> $backup"
    mv "$target" "$backup"
  fi
}

link_file() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  # 已经是正确链接则跳过
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "已存在正确软链接: $dst"
    return
  fi

  # 已存在文件/目录则备份
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    backup_target "$dst"
  fi

  ln -s "$src" "$dst"
  log "创建软链接: $dst -> $src"
}

main() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    echo "dotfiles 目录不存在: $DOTFILES_DIR"
    exit 1
  fi

  # Git 配置
  link_file "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

  # Neovim / LazyVim 配置
  link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

  log "全部完成。"
}

main "$@"
