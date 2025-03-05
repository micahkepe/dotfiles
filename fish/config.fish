# Consolidated PATH setup
set -gx PATH \
    /opt/homebrew/bin \
    $HOME/go/bin \
    $HOME/.pyenv/bin \
    /Library/TeX/texbin \
    $HOME/.rvm/bin \
    "/Users/micahkepe/.local/state/fnm_multishells/97325_1729710187621/bin" \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $PATH

# LLDB/LLVM setup
set -gx LIBLLDB_PATH /opt/homebrew/opt/llvm/lib/liblldb.dylib
set -gx DYLD_LIBRARY_PATH /opt/homebrew/opt/llvm/lib $DYLD_LIBRARY_PATH

# Snacks.nvim
set -gx SNACKS_GHOSTTY true

# Aliases
function gs; git status $argv; end
function ga; git add $argv; end
function gc; git commit $argv; end
function gp; git push $argv; end
function gd; git diff $argv; end
function gr; git restore $argv; end
function v; vim $argv; end
function tmux-sessionizer; ~/.dotfiles/tmux/tmux-sessionizer.sh $argv; end
function latex-template; ~/.dotfiles/latex/latex-template.sh $argv; end
function rm; trash $argv; end

# Yazi function
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Kitty SSH
if test -n "$KITTY_WINDOW_ID"
    function ssh; kitty +kitten ssh $argv; end
end

# fnm env setup
set -gx PATH "/Users/micahkepe/.local/state/fnm_multishells/97325_1729710187621/bin" $PATH
set -gx FNM_MULTISHELL_PATH "/Users/micahkepe/.local/state/fnm_multishells/97325_1729710187621"
set -gx FNM_VERSION_FILE_STRATEGY "local"
set -gx FNM_DIR "/Users/micahkepe/.local/share/fnm"
set -gx FNM_LOGLEVEL "info"
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist"
set -gx FNM_COREPACK_ENABLED "false"
set -gx FNM_RESOLVE_ENGINES "false"
set -gx FNM_ARCH "arm64"

# Set up fzf key bindings
fzf --fish | source

# fzf.fish key binding changes
# - change variables search to Ctrl-Alt-v
fzf_configure_bindings --variables=\e\cv

# Set up zoxide
zoxide init --cmd cd fish | source

# pyenv setup
pyenv init - fish | source

# Set Neovim as default editor
set -gx EDITOR /opt/homebrew/bin/nvim
