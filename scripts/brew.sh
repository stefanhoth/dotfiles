#!/usr/bin/env sh

echo "#############################"
echo "# Installing various programs from brew"
echo "#############################"
echo ""

ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
source "$ROOT_DIR/commands/__util.sh"

# Check for brew, install if not present
brew -v >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install common apps and packages, including vscode plugins
brew bundle install --file $CONFIG_DIR/Brewfile

# set up ZSH
FROM_DIR="$CONFIG_DIR/oh-my-zsh"
TARGET_DIR=~/.zsh-custom/
symlink_files "$FROM_DIR/*" "$TARGET_DIR"

# already installed via brew, just need to activate it
echo "Installing fast-syntax-highlighting"
source  $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh


# set zsh it as default shell
chsh -s $(brew --prefix)/bin/zsh

# set up p10k
