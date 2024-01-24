#!/usr/bin/env sh

echo ""
echo "#############################"
echo "# Installing applications via cask from cask.sh"
echo "#############################"
echo ""

# get current location
ROOT_DIR=$1

echo "installing VSCode"
brew uninstall --cask --force visual-studio-code && brew install --cask visual-studio-code

brew tap homebrew/cask-versions

echo "installing custom fonts"
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
# Fira code with fancy italics
open "$ROOT_DIR/static/fira-code-iscript/FiraCodeiScript-Regular.ttf"
open "$ROOT_DIR/static/fira-code-iscript/FiraCodeiScript-Bold.ttf"
open "$ROOT_DIR/static/fira-code-iscript/FiraCodeiScript-Italic.ttf"

brew install --cask font-oswald
brew install --cask font-ubuntu
# terminal font
brew install --cask font-caskaydia-cove-nerd-font
brew install --cask graphql-playground

brew tap jeroenknoops/tap
brew install gitin

brew install --cask google-chrome
brew install --cask google-chrome-canary
brew install --cask firefox
brew install --cask firefox-nightly
brew install --cask iterm2
# install iterm utilities right away
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

brew install --cask wavebox
brew install --cask zoom
brew install --cask spotify
brew install --cask ngrok
brew install --cask bartender
brew install --cask rocket
brew install --cask monitorcontrol
brew install --cask screenflow
brew install --cask keycastr
brew install --cask raycast
brew install --cask cron
brew install --cask signal
brew install --cask discord
brew install --cask openinterminal

# choosy needs this rosetta thing for some reasons
sudo softwareupdate --install-rosetta
brew install --cask choosy

# drivers still work with cask but have to be installed like this
brew tap homebrew/cask-drivers
brew install elgato-control-center
