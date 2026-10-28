############################################################
#
#     ███████╗██╗███████╗██╗  ██╗
#     ██╔════╝██║██╔════╝██║  ██║
#     █████╗  ██║███████╗███████║
#     ██╔══╝  ██║╚════██║██╔══██║
#     ██║     ██║███████║██║  ██║
#     ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
#
############################################################

# PATH
set -gx PATH \
    $HOME/.local/share/fnm \
    $HOME/go/bin \
    $HOME/.rvm/bin \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $HOME/.nix-profile/bin \
    $HOME/.local/share/bob/nvim-bin \
    $PATH

switch (uname)
  case "Darwin"
    set -gx PATH /opt/homebrew/bin \
      /Library/TeX/texbin \
      $PATH
    set -gx FNM_PATH "/opt/homebrew/opt/fnm/bin"
  case 'Linux'
    set -gx FNM_PATH "$HOME/.local/share/fnm"
end

# SNACKS.NVIM
set -gx SNACKS_GHOSTTY true

# ALIASES
alias gs="git status --short"
alias ga="git add"
alias gap="git add --patch"
alias gi="git init"
alias gc="git commit"
alias gl="git log"
alias gcl="git clone"
alias gp="git push"
alias gu="git pull"
alias gd="git diff"
alias gr="git restore"
alias gf="git fetch"
alias gco="git checkout"
alias gb="git branch"

alias ssh="ghostty +ssh --"

# `rm` -> `trash` (macOS), if available
if type -q trash
  alias rm="trash"
end

alias ta="tmux attach"

alias brave="open -a 'Brave Browser'"
alias chrome="open -a 'Google Chrome'"
alias firefox="open -a 'Firefox'"

alias c="clear"

# FZF.FISH KEY BINDING CHANGES
# - change variables search to Ctrl-Alt-v
fzf_configure_bindings --variables=\e\cv

# SET DEFAULT EDITOR
set -gx EDITOR nvim

# USE NEOVIM FOR MAN PAGES
export MANPAGER='nvim +Man!'

# GPG
export GPG_TTY=$(tty)

# Prompt
starship init fish | source

# Show color for ANSI color escapes
export LESS='-R'

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Haskell
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/micahkepe/.ghcup/bin $PATH # ghcup-env

# WASM
set -gx WASMTIME_HOME "$HOME/.wasmtime"
string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH

# direnv
direnv hook fish | source

# BEGIN opam configuration
test -r "$HOME.opam/opam-init/init.fish" && source "$HOME.opam/opam-init/init.fish" > /dev/null 2> /dev/null; or true
# END opam configuration
