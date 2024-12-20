#!/bin/bash

DOTFILES_DIR=~/.dotfiles

# Symlink function
symlink() {
    local src=$1 dst=$2

    # If the file already exists, skip it
    if [ -e "$dst" ]; then
        echo "File $dst already exists. Skipping..."
    else
        echo "Linking $src to $dst"
        ln -s $src $dst
    fi
}

# Link configs
symlink $DOTFILES_DIR/.bashrc ~/.bashrc
symlink $DOTFILES_DIR/.gitconfig ~/.gitconfig
symlink $DOTFILES_DIR/.vimrc ~/.vimrc
symlink $DOTFILES_DIR/.vim ~/.vim
symlink $DOTFILES_DIR/.zshrc ~/.zshrc
symlink $DOTFILES_DIR/.hammerspoon ~/.hammerspoon
symlink $DOTFILES_DIR/nvim ~/.config/nvim
symlink $DOTFILES_DIR/neofetch ~/.config/neofetch
symlink $DOTFILES_DIR/fish ~/.config/fish
symlink $DOTFILES_DIR/tmux/.tmux.conf ~/.tmux.conf
symlink $DOTFILES_DIR/wezterm ~/.config/wezterm 
symlink ~/.wezterm.lua $DOTFILES_DIR/wezterm/wezterm.lua
symlink $DOTFILES_DIR/spotify-player ~/.config/spotify-player
# add more here as needed

echo "Dotfiles linked successfully!"
