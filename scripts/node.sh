#!/usr/bin/env sh

echo ""
echo "#############################"
echo "# Running global node setup from node.sh"
echo "#############################"
echo ""

ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"

# *************************************
# fnm
#

# Check for fnm, install if not present
fnm --version >/dev/null 2>&1 || /bin/bash -c "brew install fnm"

echo "installing node via fnm (lts + latest release)"
fnm install --lts
fnm install --latest

NODE_CURRENT=$(fnm current)
echo "Currently using node $NODE_CURRENT for now. Use 'fnm use VERSION' to change this. Use 'fnm list' to see all installed versions."

echo "Installing global packages from $CONFIG_DIR/package-lists/npm-global-packages.txt"
npm install --global $(tr '\n' ' ' < $CONFIG_DIR/package-lists/npm-global-packages.txt)
