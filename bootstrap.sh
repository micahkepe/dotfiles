#!/bin/bash

# DESCRIPTION : Sets up dotfiles repository with symlinks. Additionally, gives
# prompts for installing Homebrew and Git.
#
# Run this script on a new machine using the following:
#
# ```bash
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/micahkepe/dotfiles/refs/heads/main/bootstrap.sh)"
# ```
#
# AUTHOR      : Micah Kepe
# DATE        : 2024-12-26
# UPDATED     : 2025-07-11

## Optional arguments
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "Running in dry-run mode..."
fi

## Signal handling
trap 'echo ""; echo "Exiting bootstrap script..."; exit 130' SIGINT SIGTERM

## Prerequisites checks
echo "Step 1/6: Checking prerequisites..."

### Operating system
if ! [[ $(uname -s) == "Darwin" ]]; then
  echo "This script only applies to Mac."
  exit 1
fi

### Backup check
read -rp "Have you backed up any existing configuration files? (y/n): " backupvar
if [[ "$backupvar" =~ ^[Nn] || -z "$backupvar" ]]; then
  echo "Please backup your configuration files before continuing."
  exit 1
fi

### Check if brew is installed
if ! command -v brew &>/dev/null; then
  echo "Brew is not installed."
  read -rp "Would you like to install Homebrew now?: [Y/n]" brewvar

  if [[ ! "$brewvar" =~ [Nn](o)? ]]; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Source `brew` command
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Check installation
    command -v brew &>/dev/null || {
      echo "Homebrew installation failed"
      exit 1
    }

    echo "Homebrew installed successfully!"
  fi
fi

### Check if git is installed
if ! command -v git &>/dev/null; then
  echo "Git is not installed."
  read -rp "Would you like to install Xcode Command Line Tools now?: [Y/n]" xcodevar

  if [[ ! "$xcodevar" =~ [Nn](o)? ]]; then
    # install command line tools
    command xcode-select --install
  fi
fi

## Set up dotfiles repository
echo "Step 2/6: Setting up dotfiles repository..."

# Set the dotfiles directory to `.dotfiles/` in the `$HOME` directory
DOTFILES_DIR=$HOME/dotfiles

# Creating the dotfiles repository if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  cd "$HOME" || exit
  git clone https://github.com/micahkepe/dotfiles || {
    echo "Error: Failed to clone dotfiles repo"
    exit 1
  }
else
  # pull latest
  cd "$DOTFILES_DIR" || exit
  git pull || {
    echo "Error: Failed to update dotfiles repo"
    exit 1
  }
fi

## Install Homebrew packages
echo "Step 3/6: Installing Homebrew packages..."

if command -v brew &>/dev/null; then
  echo "Installing packages from Brewfile..."
  brew bundle --file="$DOTFILES_DIR"/Brewfile
fi

## Symlink configurations
echo "Step 4/6: Creating symlinks..."

#######################################
# Symlink wrapper helper function
# Arguments:
#   $1: the source file, a path.
#   $2: the destination file, a path.
#######################################
symlink() {
  local src=$1 dst=$2

  if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY-RUN] Would link $src to $dst"
    return
  fi

  # Create the destination's intermediary parent directories if they doesn't
  # exist
  mkdir -p "$(dirname "$dst")"

  # If the destination exists and is NOT a symlink, remove it
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up $dst to ${dst}.bak"
    mv "$dst" "${dst}.bak"
  elif [ -L "$dst" ]; then
    echo "Removing broken symlink at $dst..."
    rm "$dst"
  fi

  echo "Linking $src to $dst"
  ln -sf "$src" "$dst"
}

echo "Linking dotfiles..."
symlink "$DOTFILES_DIR"/.bashrc "$HOME"/.bashrc
symlink "$DOTFILES_DIR"/.gitconfig "$HOME"/.gitconfig
symlink "$DOTFILES_DIR"/.vimrc "$HOME"/.vimrc
symlink "$DOTFILES_DIR"/.zshrc "$HOME"/.zshrc
symlink "$DOTFILES_DIR"/.cshrc "$HOME"/.cshrc
symlink "$DOTFILES_DIR"/.hammerspoon "$HOME"/.hammerspoon
symlink "$DOTFILES_DIR"/nvim "$HOME"/.config/nvim
symlink "$DOTFILES_DIR"/fastfetch "$HOME"/.config/fastfetch
symlink "$DOTFILES_DIR"/fish "$HOME"/.config/fish
symlink "$DOTFILES_DIR"/tmux/.tmux.conf "$HOME"/.tmux.conf
symlink "$DOTFILES_DIR"/wezterm "$HOME"/.config/wezterm
symlink "$DOTFILES_DIR"/spotify-player "$HOME"/.config/spotify-player
symlink "$DOTFILES_DIR"/ghostty "$HOME"/.config/ghostty
symlink "$DOTFILES_DIR"/yazi "$HOME"/.config/yazi
symlink "$DOTFILES_DIR"/karabiner "$HOME"/.config/karabiner
symlink "$DOTFILES_DIR"/sioyek/prefs_user.config "$HOME"/Library/Application Support/sioyek/prefs_user.config
symlink "$DOTFILES_DIR"/mutt "$HOME"/.config/mutt
# add more here as needed

echo "Dotfiles linked successfully!"

## Local scripts
echo "Step 5/6: Make local scripts executeable..."

LOCAL_BIN="$HOME"/.local/bin
mkdir -p "$LOCAL_BIN"

### tmux-sessionizer
chmod +x "$DOTFILES_DIR"/tmux/tmux-sessionizer.sh
cp -f "$DOTFILES_DIR"/tmux/tmux-sessionizer.sh ~/.local/bin/tmux-sessionizer
chmod +x "$DOTFILES_DIR"/latex/latex-template.sh
cp -f "$DOTFILES_DIR"/latex/latex-template.sh ~/.local/bin/latex-template

## vim-plug
echo "Step 6/6: Installing vim-plug package manager..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Local scripts made executeable!"
