# Micah's Dotfiles

![Preview of my NVChad setup for reference.](images/nvim.png)

My personal dotfiles for macOS. This repository contains my configurations for Neovim, Vim, Hammerspoon, and the terminal. I have included a bootstrap script that will create the necessary symlinks for the configurations. 

**Note**: This repository is a work in progress and is constantly being updated. Additionally, if you want to give these dotfiles a try, I recommend forking and reviewing the code before giving them a whirl.

## Features 

<details> 
<summary>NVChad Neovim Configuration</summary>
</br>
NVChad is a Neovim configuration that provides a clean and minimal setup for development. It includes plugins like Telescope, LSP, and Treesitter for a modern development experience. On top of the already versatile configuration, I have added my own plugins, mappings, and customizations. 
</details>

---

<details>
<summary>Vim Setup</summary>
</br>
I have since switched to Neovim, but I have included my old Vim configuration for reference. It replicates a lot of the features of NVChad.
</details>

---

<details>
<summary>Hammerspoon Configuration</summary>
</br>
Hammerspoon is a powerful automation tool for macOS that allows you to script and automate tasks. I have included a configuration that provides window management that I cannot live without.
</details>

---

<details>
<summary>Terminal Configurations (Zsh, Bash, etc.)</summary>
</br>
Personal configurations including aliases, themes, etc. for the terminal.
</details>

---

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

### 3. Initialize and Update Submodules
Initialize and update the git submodules to include dependencies like Vundle and YouCompleteMe.
```bash
cd ~./dotfiles
git submodule update --init --recursive
```

### 4. Install Homebrew
Only if it's not already installed.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 5. Install Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 6. Install Packages and Apps with Homebrew (Command-Line Tools, Docker, etc.)
If you have a Brewfile in your dotfiles:
```bash
brew bundle install --file ~/.dotfiles/Brewfile
```

### 7. Install HammerSpoon
```bash
brew install --cask hammerspoon
```

### 8. Run Bootstrap Script
This will create the necessary symlinks for your configurations.
```bash
bash ~/.dotfiles/bootstrap.sh
```

### 9. Source Shell Configuration
Either open a new terminal session or source the configuration files with:
```bash
source ~/.zshrc
```

And that's it! If you have any suggestions or questions feel free to open an issue or contact me.

## Troubleshooting

For YCM server shut down errors, ensure that the `install.py` script is installed via the system Python installation (`/opt/homebrew/bin/python3 ./install.py --all`) and **NOT** the conda installation. Additionally, you may need to install `setuptools` (`brew install python-setuptools`).

For MarkdownPreview, if the build fails, run `:Lazy load markdown-preview.nvim` and then `:call mkdp#util#install()` in Neovim.
