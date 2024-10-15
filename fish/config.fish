# Homebrew
set -gx PATH /opt/homebrew/bin $PATH

# Set GOBIN to the go bin directory
set -gx GOBIN $HOME/go/bin

# Add the go bin directory to the PATH
set -gx PATH $PATH $GOBIN

# ALIASES
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias v="vim"

# Using the Fish shell in SSH w/ Kitty terminal emulator
#
# DO NOT SET `TERM` to a value other than the Kitty default:
#   https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.term
if test -n "$KITTY_WINDOW_ID"
    # Alias for ssh to use kitty terminal emulator
    alias ssh="kitty +kitten ssh"
end
