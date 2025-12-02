# fnm
#   See: https://github.com/Schniz/fnm/blob/master/README.md#fish-shell
if command -q fnm
  fnm env --use-on-cd --shell fish | source
end
