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

. "$HOME/.cargo/env"
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN

########################
#  ALIASES
########################

# Command Aliases
alias dc='cd'
alias ll='ls -al'
alias gs='git status'
alias v='vim'
alias tmux-sessionizer='~/.dotfiles/tmux/tmux-sessionizer.sh'
alias sd="cd ~ && cd \$(find * -type d | fzf)"

# Directory Aliases
alias ..='cd ..'
alias ...='cd ../..'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
