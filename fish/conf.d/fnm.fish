# fnm
if uname -a | grep -q "Darwin";
  set FNM_PATH "/opt/homebrew/opt/fnm/bin"
else
  set FNM_PATH "$HOME/.local/share/fnm"
end

if [ -d "$FNM_PATH" ]
  fnm env --shell fish | source
end
