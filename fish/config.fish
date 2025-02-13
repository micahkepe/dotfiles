# Homebrew
set -gx PATH /opt/homebrew/bin $PATH

# Set GOBIN to the go bin directory
set -gx GOBIN $HOME/go/bin

# Add the go bin directory to the PATH
set -gx PATH $PATH $GOBIN

# pyenv setup
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

# MacTeX
set -gx PATH /Library/TeX/texbin $PATH

# rvm
set -gx PATH $HOME/.rvm/bin $PATH

# ALIASES
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gd="git diff"
alias gr="git restore"
alias v="vim"
alias tmux-sessionizer="~/.dotfiles/tmux/tmux-sessionizer.sh"
alias latex-template="~/.dotfiles/latex/latex-template.sh"
alias rm="trash"

# Using the Fish shell in SSH w/ Kitty terminal emulator
#
# DO NOT SET `TERM` to a value other than the Kitty default:
#   https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.term
if test -n "$KITTY_WINDOW_ID"
    # Alias for ssh to use kitty terminal emulator
    alias ssh="kitty +kitten ssh"
end

# fnm env setup for fish
set -gx PATH "/Users/micahkepe/.local/state/fnm_multishells/97325_1729710187621/bin" $PATH;
set -gx FNM_MULTISHELL_PATH "/Users/micahkepe/.local/state/fnm_multishells/97325_1729710187621";
set -gx FNM_VERSION_FILE_STRATEGY "local";
set -gx FNM_DIR "/Users/micahkepe/.local/share/fnm";
set -gx FNM_LOGLEVEL "info";
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
set -gx FNM_COREPACK_ENABLED "false";
set -gx FNM_RESOLVE_ENGINES "false";
set -gx FNM_ARCH "arm64";

# Set up fzf key bindings
fzf --fish | source

# fzf.fish key binding changes
# - change variables search to Ctrl-Alt-v
fzf_configure_bindings --variables=\e\cv

zoxide init --cmd cd fish | source
