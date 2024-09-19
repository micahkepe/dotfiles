# Homebrew
set -gx PATH /opt/homebrew/bin $PATH

# Set GOBIN to the go bin directory
set -gx GOBIN $HOME/go/bin

# Add the go bin directory to the PATH
set -gx PATH $PATH $GOBIN

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/micahkepe/anaconda3/bin/conda
    eval /Users/micahkepe/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# ALIASES
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
