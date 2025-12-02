set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH

# lazy load only when 'python' or pyenv commands are used
function __pyenv_lazy_load
    functions -e __pyenv_lazy_load
    eval (pyenv init -|sed 's/set -gx PATH /# /')
    pyenv init - fish | source
end

function pyenv
    __pyenv_lazy_load
    command pyenv $argv
end

# intercept python only if needed
for cmd in python python3 pip pip3
    function $cmd
        __pyenv_lazy_load
        command $cmd $argv
    end
end

