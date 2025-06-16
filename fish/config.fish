# PATH
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

# LLDB/LLVM SETUP
set -gx LIBLLDB_PATH /opt/homebrew/opt/llvm/lib/liblldb.dylib
set -gx DYLD_LIBRARY_PATH /opt/homebrew/opt/llvm/lib $DYLD_LIBRARY_PATH

# Set JAVA_HOME environment variable
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home

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
function v; vim $argv; end
function tmux-sessionizer; ~/.dotfiles/tmux/tmux-sessionizer.sh $argv; end
function latex-template; ~/.dotfiles/latex/latex-template.sh $argv; end
function rm; trash $argv; end
function tn; tmux new -s $argv; end
function ta; tmux attach-session; end
function tl; tmux list-session; end
alias fabric="fabric-ai"

# FABRIC
function yt
    if test (count $argv) -eq 0 -o (count $argv) -gt 2
        echo "Usage: yt [-t | --timestamps] youtube-link"
        echo "Use the '-t' flag to get the transcript with timestamps."
        return 1
    end

    set transcript_flag "--transcript"

    if test "$argv[1]" = "-t" -o "$argv[1]" = "--timestamps"
        set transcript_flag "--transcript-with-timestamps"
        set -e argv[1]
    end

    set video_link $argv[1]
    fabric -y "$video_link" $transcript_flag
end

# KITTY SSH
if test -n "$KITTY_WINDOW_ID"
    function ssh; kitty +kitten ssh $argv; end
end

# FNM ENV SETUP
set -gx PATH "/Users/micahkepe/.local/state/fnm_multishells/97325_1729710187621/bin" $PATH
set -gx FNM_MULTISHELL_PATH "/Users/micahkepe/.local/state/fnm_multishells/97325_1729710187621"
set -gx FNM_VERSION_FILE_STRATEGY "local"
set -gx FNM_DIR "/Users/micahkepe/.local/share/fnm"
set -gx FNM_LOGLEVEL "info"
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist"
set -gx FNM_COREPACK_ENABLED "false"
set -gx FNM_RESOLVE_ENGINES "false"
set -gx FNM_ARCH "arm64"

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
