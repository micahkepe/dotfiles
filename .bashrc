############################################################
#
#     ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
#     ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
#     ██████╔╝███████║███████╗███████║██████╔╝██║
#     ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
#     ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
#     ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
############################################################

########################
#  PATH SETUP
########################

# Cargo path
export PATH=$PATH:"$HOME/.cargo/env"

# Go path
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN

# MacTeX
export PATH=/Library/TeX/texbin:$PATH

########################
#  ALIASES
########################

alias gs="git status --short"
alias gc="git commit"
alias gi="git init"
alias gcl="git clone"
alias ga="git add"
alias gap="git add --patch"
alias gd="git diff"
alias gr="git restore"
alias gp="git push"
alias gu="git pull"
alias gf="git fetch"
alias gco="git checkout"
alias v="vim"
if command -v trash &>/dev/null; then
  alias rm="trash"
fi
alias c="clear"

#######################################
# Utility function to start a new tmux
# session with the given name.
# Arguments:
#   $1: the session name
#######################################
function new_tmux_session() {
  if [ -z "$1" ]; then
    echo "Usage: new_tmux_session <session_name>"
    return 1
  fi
  tmux new-session -s "$1"
}

alias tn=new_tmux_session
alias ta="tmux attach-session"
alias tl="tmux list-session"

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

# Yazi
function y() {
  local tmp
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd" || exit
  fi
  rm -f -- "$tmp"
}

# Use Neovim as default editor
export EDITOR="nvim"

# GPG
GPG_TTY=$(tty)
export GPG_TTY

# Use Neovim for man pages
export MANPAGER='nvim +Man!'
