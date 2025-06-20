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
alias v="vim"
alias rm="trash"
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
alias fabric="fabric-ai"

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
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd" || exit
  fi
  rm -f -- "$tmp"
}

# Fabric

# Loop through all files in the ~/.config/fabric/patterns directory
for pattern_file in "$HOME"/.config/fabric/patterns/*; do
  # Get the base name of the file (i.e., remove the directory path)
  pattern_name=$(basename "$pattern_file")

  # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
  alias_command="alias $pattern_name='fabric --pattern $pattern_name'"

  # Evaluate the alias command to add it to the current shell
  eval "$alias_command"
done

yt() {
  if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
    echo "Usage: yt [-t | --timestamps] youtube-link"
    echo "Use the '-t' flag to get the transcript with timestamps."
    return 1
  fi

  transcript_flag="--transcript"
  if [ "$1" = "-t" ] || [ "$1" = "--timestamps" ]; then
    transcript_flag="--transcript-with-timestamps"
    shift
  fi
  local video_link="$1"
  fabric -y "$video_link" $transcript_flag
}

# Use Neovim as default editor
export EDITOR="/opt/homebrew/bin/nvim"

# GPG
export GPG_TTY=$(tty)

# Use Neovim for man pages
export MANPAGER='nvim +Man!'
