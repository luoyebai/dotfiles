#!/usr/bin/env bash

echo "==> Detecting privilege..."

if [ "$EUID" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        echo "Error: need root or sudo."
        exit 1
    fi
else
    SUDO=""
fi

echo "==> Updating package list..."
$SUDO apt update

echo "==> Installing dependencies..."
$SUDO apt install -y zsh wget curl git ripgrep vim

echo "==> Setting zsh as default shell..."
ZSH_PATH=$(which zsh)

if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | $SUDO tee -a /etc/shells
fi

if [ "$SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH" || true
fi

echo "==> Installing Zim..."
if [ ! -d "$HOME/.zim" ]; then
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    echo "Zim already installed."
fi


echo "==> Installing Vim plug..."
if [ ! -d "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "Vim plug already installed."
fi


echo "==> Installing dotfiles"
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_HOME="$HOME"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$TARGET_HOME/.dotfiles_backup_$TIMESTAMP"
FILES=(
  ".alias.zsh"
  ".fzf.zsh"
  ".vimrc"
  ".zimrc"
  ".zshenv"
  ".zshrc"
)
DIRS=(
  ".zim"
  ".fzf"
)
echo "Source: $DOTFILES_DIR"
echo "Target: $TARGET_HOME"
mkdir -p "$BACKUP_DIR"
backup() {
  if [ -e "$1" ]; then
    echo "Backing up $1"
    mv "$1" "$BACKUP_DIR/"
  fi
}

for file in "${FILES[@]}"; do
  if [ -f "$DOTFILES_DIR/$file" ]; then
    backup "$TARGET_HOME/$file"
    cp -a "$DOTFILES_DIR/$file" "$TARGET_HOME/"
  fi
done

for dir in "${DIRS[@]}"; do
  if [ -d "$DOTFILES_DIR/$dir" ]; then
    backup "$TARGET_HOME/$dir"
    cp -a "$DOTFILES_DIR/$dir" "$TARGET_HOME/"
  fi
done

echo "Backup directory: $BACKUP_DIR"

"$TARGET_HOME/.fzf/install"

echo "==> Done."
echo "Restart shell or run: exec zsh"
