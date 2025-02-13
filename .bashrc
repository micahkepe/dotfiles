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

alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gp='git push'
alias gd='git diff'
alias gr='git restore'
alias v='vim'
alias tmux-sessionizer='~/.dotfiles/tmux/tmux-sessionizer.sh'
alias rm='trash'


#######################
#  MISC.
#######################

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

eval "$(zoxide init --cmd cd bash)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
