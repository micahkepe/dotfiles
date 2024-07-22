# Dotfiles Setup Guide

This README provides steps to set up dotfiles and configurations on a new machine.

## Prerequisites

Before starting, ensure that the following are installed:
- Git
- Homebrew
- Oh My Zsh 
- Hammerspoon

## Setup Steps

### 1. Install Apple Command Line Tools
This will provide you with essential tools like git.
```bash
xcode-select --install
```

### 2. Clone Dotfiles Repo
Clone your dotfiles repository into a new hidden directory.
```bash
git clone https://github.com/micahkepe/dotfiles.git ~/.dotfiles
```

### 3. Install Homebrew
Only if it's not already installed.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 4. Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 5. Install Packages and Apps with Homebrew (Command-Line Tools, Docker, etc.)
If you have a Brewfile in your dotfiles:
```bash
brew bundle install --file ~/.dotfiles/Brewfile
```

### 6. Install HammerSpoon
```bash
brew install --cask hammerspoon
```

### 7. Run Bootstrap Script
This will create the necessary symlinks for your configurations.
```bash
bash ~/.dotfiles/bootstrap.sh
```

### 8. Source Shell Configuration
Either open a new terminal session or source the configuration files with:
```bash
source ~/.zshrc
```

And that's it! If you have any suggestions or questions feel free to open an issue or contact me.
