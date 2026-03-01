#!/usr/bin/env bash

current="$(tmux display-message -p '#S')"

tmux list-sessions -F '#S' |
  grep -v "^$current$" |
  fzf --tmux --reverse |
  xargs -r -I{} tmux switch-client -t "{}"
