# Dotfiles Setup Guide

This README provides steps to set up dotfiles and configurations on a new machine.

## Setup Steps

### 1. Install Apple Command Line Tools
This will provide you with essential tools like git.
```bash
xcode-select --install
```

### 2. Clone Dotfiles Repo
Clone your dotfiles repository into a new hidden directory.
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

### 3. Run Bootstrap Script
This will create the necessary symlinks for your configurations.
```bash
bash ~/.dotfiles/bootstrap.sh
```

### 4. Install Homebrew
Only if it's not already installed.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 5. Install Packages and Apps with Homebrew
If you have a Brewfile in your dotfiles:
```bash
brew bundle install --file ~/.dotfiles/Brewfile
```
