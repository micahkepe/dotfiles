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
    /opt/homebrew/opt/coreutils/libexec/gnubin \
    /opt/homebrew/bin \
    $HOME/go/bin \
    $HOME/.pyenv/bin \
    /Library/TeX/texbin \
    $HOME/.rvm/bin \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $PATH

# LLDB/LLVM SETUP
set -gx LIBLLDB_PATH /opt/homebrew/opt/llvm/lib/liblldb.dylib
set -gx DYLD_LIBRARY_PATH /opt/homebrew/opt/llvm/lib $DYLD_LIBRARY_PATH

# Set JAVA_HOME environment variable
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home
set -gx PATH $JAVA_HOME/bin $PATH

# SNACKS.NVIM
set -gx SNACKS_GHOSTTY true

# ALIASES
function gs; git status --short $argv; end
function ga; git add $argv; end
function gap; git add --patch $argv; end
function gi; git init $argv; end
function gc; git commit $argv; end
function gl; git log $argv; end
function gcl; git clone $argv; end
function gp; git push $argv; end
function gu; git pull $argv; end
function gd; git diff $argv; end
function gr; git restore $argv; end
function gf; git fetch $argv; end
complete --command gs --wraps 'git status --short'
complete --command ga --wraps 'git add'
complete --command gap --wraps 'git add --patch'
complete --command gi --wraps 'git init'
complete --command gc --wraps 'git commit'
complete --command gl --wraps 'git log'
complete --command gcl --wraps 'git clone'
complete --command gp --wraps 'git push'
complete --command gu --wraps 'git pull'
complete --command gd --wraps 'git diff'
complete --command gr --wraps 'git restore'
complete --command gf --wraps 'git fetch'

function v; vim $argv; end
complete --command l --wraps 'vim'

function l; ls -lah; end

# `rm` -> `trash` (macOS), if available
if type -q trash
  function rm; trash $argv; end
  complete --command rm --wraps 'rm'
end

function tn; tmux new -s $argv; end
complete --command tn --wraps 'tmux new -s'
function ta; tmux attach $argv; end
complete --command ta --wraps 'tmux attach'
function tl; tmux list-session; end

function brave; open -a "Brave Browser" $argv; end
complete --command brave --wraps 'open -a "Brave Browser"'
function chrome; open -a "Google Chrome" $argv; end
complete --command brave --wraps 'open -a "Google Chrome"'
function firefox; open -a "Firefox" $argv; end
complete --command brave --wraps 'open -a "Firebox"'

function c; clear $argv; end

# KITTY SSH
if test -n "$KITTY_WINDOW_ID"
    function ssh; kitty +kitten ssh $argv; end
end

# SET UP FZF KEY BINDINGS
fzf --fish | source

# FZF.FISH KEY BINDING CHANGES
# - change variables search to Ctrl-Alt-v
fzf_configure_bindings --variables=\e\cv

# SET UP ZOXIDE
zoxide init --cmd cd fish | source

# PYENV SETUP
pyenv init - fish | source

# SET DEFAULT EDITOR
set -gx EDITOR nvim

# USE NEOVIM FOR MAN PAGES
export MANPAGER='nvim +Man!'

# GPG
export GPG_TTY=$(tty)

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
