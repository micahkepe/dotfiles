# Activates a virtual environment in the current shell
# Usage:
#    activate <path_to_venv>
#
# This is a workaround for the fact that fish does not directly support the use 
# of the `source` command in functions.
function activate
    if test -f $argv[1]/bin/activate.fish
        source $argv[1]/bin/activate.fish
    else
        echo "Usage: activate <path_to_venv>"
    end
end
