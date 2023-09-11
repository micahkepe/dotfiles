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

### 5. Install Useful Command Line Tools
```bash
brew install ack awscli bat colima diff-so-fancy docker docker-compose jq localstack n nmap node nvm tldr tree watch wget yarn zsh-completions
```

### 6. Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 7. Install Packages and Apps with Homebrew
If you have a Brewfile in your dotfiles:
```bash
brew bundle install --file ~/.dotfiles/Brewfile
```

**Note**: After the setup, ensure to open a new terminal session or ``` source  ~/.zshrc ``` for all changes to take effect.
