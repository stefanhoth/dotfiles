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


# set it as default shell
chsh -s /bin/zsh

# set up p10k
