#!/usr/bin/env bash

# Adapted from: https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
#
# Description: 
#   A script to create a new tmux session either by passing in a directory or 
#   selecting one with fzf. For ease of use, add this script to your $PATH and
#   create an alias in your shell configuration file (e.g. .bashrc, .zshrc) like:
#   alias tmux-sessionizer='tmux-sessionizer.sh'
#
#   Then you can simply run with `tmux-sessionizer`
#
# Usage: 
#  tmux-sessionizer.sh [directory]
#  tmux-sessionizer.sh


if [[ $# -eq 1 ]]; then
    selected=$1
else
    # if no directory is passed in, use fzf to select one
    # NOTE: change the directories to search in the find command as you wish
    selected=$(FZF_TMUX=1 find ~/coding ~ ~/vislang/ ~/rice/* -mindepth 1 -maxdepth 1 -type d | fzf)
fi

# exit if no directory is selected from fzf
if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# create new session if not in tmux
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

# create new session if name doesn't exist
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -n $TMUX ]]; then
    tmux switch-client -t $selected_name
else
    # if running outside of tmux, attach to the new session
    tmux attach-session -t $selected_name
fi
