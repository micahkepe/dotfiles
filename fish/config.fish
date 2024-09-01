set -gx PATH /opt/homebrew/bin $PATH

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
