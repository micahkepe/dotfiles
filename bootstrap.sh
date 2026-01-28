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
# Usage:
#   ./bootstrap.sh [--dry-run]
#
# AUTHOR      : Micah Kepe
# DATE        : 2024-12-26
# UPDATED     : 2025-08-22

DRY_RUN=false

while [[ "$#" -gt 0 ]]; do
  case "$1" in
  -h | --help)
    echo "Usage: bootstrap.sh [--dry-run]"
    echo ""
    echo "Options:"
    echo "  --dry-run  : Dry run mode. Prints commands without executing them."
    exit 0
    ;;
  --dry-run)
    DRY_RUN=true
    ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
  shift
done

if [[ "$DRY_RUN" == "true" ]]; then
  echo "Running in dry-run mode..."
  echo "No changes will be made to your system unless you accept the prompts."
fi

#######################################
# Exec-dry-run wrapper function
# Arguments:
#   $1: the command to execute
# Effects:
#   If DRY_RUN is true, prints the command to be executed.
#   Otherwise, executes the command.
#######################################
exec-dry-run() {
  if [[ "$DRY_RUN" == "true" ]]; then
    echo "[DRY-RUN] Would execute: $*"
  elif [[ "$DRY_RUN" == "false" ]]; then
    eval "$*"
  fi
}

## Signal handling
trap 'echo ""; echo "Exiting bootstrap script..."; exit 130' SIGINT SIGTERM

## Prerequisites checks
echo "Step 1/9: Checking prerequisites..."

### Operating system
OS=$(uname -s)
if ! [[ "$OS" == "Darwin" || "$OS" == "Linux" ]]; then
  echo "This script only applies to Mac and Linux."
  exit 1
fi

### Backup check
read -rp "Have you backed up any existing configuration files? (y/n): " backupvar
if [[ "$backupvar" =~ ^[Nn] || -z "$backupvar" ]]; then
  echo "Please backup your configuration files before continuing."
  exit 1
fi

### MAC: Check if brew is installed
if [[ "$OS" == "Darwin" ]]; then
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
fi

## Set up dotfiles repository
echo "Step 2/9: Setting up dotfiles repository..."

# Set the dotfiles directory to `.dotfiles/` in the `$HOME` directory
DOTFILES_DIR=$HOME/dotfiles

# Creating the dotfiles repository if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  exec-dry-run git clone https://github.com/micahkepe/dotfiles "$DOTFILES_DIR" || {
    echo "Error: Failed to clone dotfiles repo"
    exit 1
  }
else
  # pull latest
  exec-dry-run cd "$DOTFILES_DIR" || exit
  exec-dry-run git pull || {
    echo "Error: Failed to update dotfiles repo"
    exit 1
  }
fi

## Install Homebrew packages
echo "Step 3/9: Installing Homebrew packages..."

if [[ "$OS" == "Darwin" ]]; then
  if command -v brew &>/dev/null; then
    echo "Installing packages from Brewfile..."
    exec-dry-run brew bundle --file="$DOTFILES_DIR"/Brewfile
  fi
else
  echo "Skipping (not on macOS)..."
fi

## Symlink configurations
echo "Step 4/9: Creating symlinks..."

#######################################
# Symlink wrapper helper function
# Arguments:
#   $1: the source file, a path.
#   $2: the destination file, a path.
#######################################
symlink() {
  local src=$1 dst=$2

  # Check dry-run mode
  if [[ "$DRY_RUN" == "true" ]]; then
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
if [[ "$OS" == "Darwin" ]]; then
  symlink "$DOTFILES_DIR"/.hammerspoon "$HOME"/.hammerspoon
  symlink "$DOTFILES_DIR"/karabiner "$HOME"/.config/karabiner
  symlink "$DOTFILES_DIR"/sioyek/prefs_user.config "$HOME"/Library/Application Support/sioyek/prefs_user.config
fi
if [[ "$OS" == "Linux" ]]; then
  symlink "$DOTFILES_DIR"/sioyek/prefs_user.config "$HOME"/.config/sioyek/prefs_user.config
  symlink "$DOTFILES_DIR"/hypr "$HOME"/.config/hypr
  symlink "$DOTFILES_DIR"/kanata "$HOME"/.config/kanata
  symlink "$DOTFILES_DIR"/waybar "$HOME"/.config/waybar
fi
symlink "$DOTFILES_DIR"/.bashrc "$HOME"/.bashrc
symlink "$DOTFILES_DIR"/.gitconfig "$HOME"/.gitconfig
symlink "$DOTFILES_DIR"/.vimrc "$HOME"/.vimrc
symlink "$DOTFILES_DIR"/.zshrc "$HOME"/.zshrc
symlink "$DOTFILES_DIR"/.cshrc "$HOME"/.cshrc
symlink "$DOTFILES_DIR"/nvim "$HOME"/.config/nvim
symlink "$DOTFILES_DIR"/fastfetch "$HOME"/.config/fastfetch
symlink "$DOTFILES_DIR"/fish "$HOME"/.config/fish
symlink "$DOTFILES_DIR"/tmux/.tmux.conf "$HOME"/.tmux.conf
symlink "$DOTFILES_DIR"/spotify-player "$HOME"/.config/spotify-player
symlink "$DOTFILES_DIR"/ghostty "$HOME"/.config/ghostty
symlink "$DOTFILES_DIR"/mutt "$HOME"/.config/mutt
symlink "$DOTFILES_DIR"/btop "$HOME"/.config/btop
# add more here as needed

echo "Dotfiles linked successfully!"

## Local scripts
echo "Step 5/9: Make local scripts executeable..."

LOCAL_BIN="$HOME"/.local/bin
exec-dry-run mkdir -p "$LOCAL_BIN"
exec-dry-run chmod +x "$DOTFILES_DIR"/tmux/tmux-sessionizer.sh
exec-dry-run chmod +x "$DOTFILES_DIR"/tmux/session-fzf.sh
exec-dry-run chmod +x "$DOTFILES_DIR"/tmux/is-vim.sh
exec-dry-run symlink "$DOTFILES_DIR"/tmux/tmux-sessionizer.sh "$HOME"/.local/bin/tmux-sessionizer
exec-dry-run symlink "$DOTFILES_DIR"/tmux/tmux-worktreeizer.sh "$HOME"/.local/bin/tmux-worktreeizer
exec-dry-run chmod +x "$DOTFILES_DIR"/latex/latex-template.sh
exec-dry-run symlink "$DOTFILES_DIR"/latex/latex-template.sh "$HOME"/.local/bin/latex-template
echo "Local scripts made executeable!"

## vim-plug
echo "Step 6/9: Installing vim-plug package manager..."
exec-dry-run curl -fLo "$HOME"/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## tpm
echo "Step 7/9: Installing tpm package manager..."
exec-dry-run mkdir -p "$HOME"/.tmux/plugins
exec-dry-run git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
exec-dry-run tmux source "$HOME"/.tmux.conf

# Catppuccin theme for tmux
exec-dry-run mkdir -p ~/.config/tmux/plugins/catppuccin
exec-dry-run git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Rust install
echo "Step 8/9: Installing Rust..."
exec-dry-run curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Pyenv install (if not installed)
echo "Step 9/9: Checking for pyenv..."
if ! command -v pyenv &>/dev/null; then
  if [[ "$OS" == "Linux" ]]; then
    exec-dry-run curl -fsSL https://pyenv.run | bash
  elif [[ "$OS" == "Darwin" ]]; then
    exec-dry-run brew install pyenv
  fi
fi

if ! command -v diff-so-fancy &>/dev/null; then
  if [[ "$OS" == "Darwin" ]]; then
    exec-dry-run brew install diff-so-fancy
  elif [[ "$OS" == "Linux" ]]; then
    echo "NOTE: Install diff-so-fancy manually with your package manager."
  fi
fi

# MacOS key repeat rate
# See:
#   https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x
if [[ "$OS" == "Darwin" ]]; then
  defaults write -g InitialKeyRepeat -float 10.0 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -float 1.0         # normal minimum is 2 (30 ms)
fi

# FNM install
exec-dry-run curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

# uv install
exec-dry-run curl -LsSf https://astral.sh/uv/install.sh | sh

# pynvim install
exec-dry-run uv tool install --upgrade pynvim

echo "Bootstrap script complete!"
