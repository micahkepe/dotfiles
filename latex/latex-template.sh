#!/usr/bin/env bash

# Description: 
#   Copy the contents of ~/.dotfiles/latex/*.tex to the current directory 
#
# Usage:
#  latex-template.sh [directory] 
#
#  If no directory is passed in, the script will copy the contents of the 
#  file passed in to the current directory.

if [[ $# -eq 1 ]]; then
    dir=$1
else
    dir=$(pwd)
fi 

cp ~/.dotfiles/latex/*.tex $dir 

