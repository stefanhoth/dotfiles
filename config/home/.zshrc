export PATH=:/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/.bin:$HOME/.go-modules/bin:/opt/homebrew/bin:/usr/local/opt/curl/bin:$HOME/.iterm2:$PATH
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export GOPATH=$HOME/.go-modules
export EDITOR=code
export LC_ALL=en_US.UTF-8
export ZSH_PLUGINS_ALIAS_TIPS_TEXT='❗  Use the alias: '

export _Z_CMD="j"
. ~/.bin/z.sh

################################################################################
# private
source ~/.my-config.sh

################################################################################
# zsh
# make rm something/* safer
unsetopt RM_STAR_SILENT
setopt RM_STAR_WAIT
# make command prefixed with space not appear in history
setopt histignorespace
# remove dups from history
setopt hist_ignore_all_dups


################################################################################
# things for the `lc` command
LC_DELIMITER_START="⋮";
LC_DELIMITER_END="⭐";

# write current command location to `.zsh_history_ext` whenever a command is ran
# `.zsh_history_ext` is used in `lc` command
function zshaddhistory() {
  # ignore empty commands
  if [[ $1 == $'\n' ]]; then return; fi

  # ignore specific commands
  local COMMANDS_TO_IGNORE=( ls ll cd j git gss gap lc ggpush ggpull);
  for i in "${COMMANDS_TO_IGNORE[@]}"
  do
    # return if the run commands starts with the ignored commands
    if [[ $1 == "$i"* ]]; then
      return;
    fi
  done

  echo "${1%%$'\n'}${LC_DELIMITER_START}${PWD}${LC_DELIMITER_END}" >> ~/.lc_history
}

# `lc` – last command
function lc() {
  SELECTED_COMMAND=$(grep -a --color=never "${PWD}${LC_DELIMITER_END}" ~/.lc_history | cut -f1 -d "${LC_DELIMITER_START}" | tail -r | fzf);

  # handle case of selecting no command via fzf
  if [[ ${#SELECTED_COMMAND} -gt 0 ]]; then
    echo "Running '$SELECTED_COMMAND'..."
    echo "**************************"
    eval " $SELECTED_COMMAND";
  fi
}

################################################################################
# oh-my-zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh customisation.
export ZSH_CUSTOM="/Users/stefan/.zsh-custom"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    alias-tips
    git
    gitfast
    git-auto-fetch
#    git-prompt
    common-aliases
    command-not-found
    colored-man-pages
    colorize
    dirhistory
    dotenv
    fast-syntax-highlighting
#    vscode
#    ssh-agent
#    kubectl
    zsh-autosuggestions
    )

# Customize history
HIST_STAMPS="yyyy-mm-dd"

source $ZSH/oh-my-zsh.sh

################################################################################
# iterm

# https://www.iterm2.com/documentation-shell-integration.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# set variables for iterm status bar
iterm2_print_user_vars() {
  it2git
  iterm2_set_user_var nodeVersion $(node -v)
  iterm2_set_user_var pwd $(pwd)
}

# mcfly
eval "$(mcfly init zsh)"

################################################################################
# fnm setup
################################################################################

fnm completions --shell zsh  > /dev/null 2>&1
eval "$(fnm env --use-on-cd --corepack-enabled  --resolve-engines)"
export PATH="./node_modules/.bin/:$PATH"
