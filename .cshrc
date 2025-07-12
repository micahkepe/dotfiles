# For Rice CLEAR server

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

set complete = enhance

# tcsh-specific features
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
