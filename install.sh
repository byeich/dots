#!/usr/bin/env bash
set -euo pipefail

DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "  linked $dst → $src"
}

echo "Installing dotfiles from $DOTS_DIR"

symlink "$DOTS_DIR/zsh/.zshrc"     "$HOME/.zshrc"
symlink "$DOTS_DIR/git/.gitconfig" "$HOME/.gitconfig"

echo "Done. Reload shell: source ~/.zshrc"
