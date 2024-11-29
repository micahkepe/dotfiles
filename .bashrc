######################################################################
#
#
#           ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
#           ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
#           ██████╔╝███████║███████╗███████║██████╔╝██║     
#           ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║     
#           ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
#           ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
#
######################################################################

######################## 
#  PATH SETUP
########################

# Cargo path
. "$HOME/.cargo/env"

# Go path
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN

# MacTeX 
export PATH=/Library/TeX/texbin:$PATH


########################
#  ALIASES
########################

# Command Aliases
alias dc='cd'
alias ll='ls -al'
alias gs='git status'
alias v='vim'
alias tmux-sessionizer='~/.dotfiles/tmux/tmux-sessionizer.sh'
alias sd="cd \$(find * -type d | fzf)"

# Directory Aliases
alias ..='cd ..'
alias ...='cd ../..'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
