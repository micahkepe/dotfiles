function __direnv_refresh_completions --on-variable XDG_DATA_DIRS
    for d in (string split : $XDG_DATA_DIRS)
        set -l c $d/fish/vendor_completions.d
        if test -d $c; and not contains $c $fish_complete_path
            set -gx fish_complete_path $fish_complete_path $c
        end
    end
end
