# For Rice CLEAR server

# Prioritze local scripts (so I can use newer version of Neovim than the system
# installed version)
# *sigh* the things we do when Rice admin won't just give me sudo privileges smh
setenv PATH ~/.local/bin\:$PATH

# Python
#   https://kb.rice.edu/internal/71857
setenv PATH "$PATH\:/opt/rice/python-3.9.1/bin"

# Prepend local library path, but avoid undefined variable error
if (! $?LD_LIBRARY_PATH) then
    setenv LD_LIBRARY_PATH "$HOME/.local/lib"
else
    setenv LD_LIBRARY_PATH "$HOME/.local/lib:$LD_LIBRARY_PATH"
endif

## Better statusline
if ($?tcsh) then
    alias gitbranch 'set noglob; set br=""; if (-d .git || `git rev-parse --is-inside-work-tree >& /dev/null`) set br=`git branch --show-current`; if ("$br" != "") set br=" ($br)"; unset noglob'
    gitbranch
    set prompt = "%{\033[32m%}%n%{\033[0m%}@%{\033[36m%}%m%{\033[0m%}:%{\033[33m%}%~%{\033[0m%}%{\033[35m%}$br%{\033[0m%} %{\033[31m%}➜%{\033[0m%} "
else
    set br=""
    if (`git rev-parse --is-inside-work-tree >& /dev/null`) then
        set br=`git branch --show-current`
        if ("$br" != "") then
            set br=" ($br)"
        endif
    endif
    set prompt = "%n@%m:%~$br ➜ "
endif

setenv TERM xterm-256color

set complete = enhance

# tcsh-specific features
# Taken from: https://home.cs.colorado.edu/~kena/classes/3308/f04/reference/cshrc.html
if ($?tcsh != 0) then
    limit coredumpsize 1k
    unset autologout    # don't log me off after a set idle time
    set echo_style both # emulate bsd and sysV /bin/echo's
    set addsuffix   # / on dir during file name completion
    set ampm        # show times in 12 hr. format
    set autolist    # list possibilities for file name completion
    set autoexpand  # expand history automatically with
endif

# Set the editor to use
setenv EDITOR vim

## Command history
set history = 1000
set savehist = 1000
set histfile = ~/.csh_history

## Aliases
alias .. "cd .."
alias gs "git status --short"
alias gc "git commit"
alias gi "git init"
alias gcl "git clone"
alias ga "git add"
alias gap "git add --patch"
alias gd "git diff"
alias gr "git restore"
alias gp "git push"
alias gu "git pull"
alias v "vim"

