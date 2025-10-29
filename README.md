# Micah's Dotfiles

![Preview of my Neovim setup.](images/nvim.png)

My personal dotfiles for macOS/Linux. This repository contains my configurations
for Neovim/ Vim, Hammerspoon, and more. I have included a bootstrap script that
will create the necessary symlinks for the configurations and install required
packages.

> [!NOTE]
> This repository is a work in progress and is constantly being updated.
> Additionally, if you want to give these dotfiles a try, I recommend forking
> and reviewing the code before giving them a whirl.

<details>
<summary>Neofetch</summary>

**MacOS**:

![Neofetch Mac output](./images/neofetch-macos.png)

**Linux**:

![Fastfetch Linux output](./images/fastfetch-omarchy.png)

</details>

<details>
<summary>Vimtex/ Sioyek</summary>

![LaTeX editing](./images/latex.png)

</details>

<details>
<summary>Spotify Player</summary>

![Spotify player in the terminal](./images/spotify-player.png)

</details>

## Quick Setup (Recommended)

Run the bootstrap script to setup prerequisites like Homebrew and Xcode
Command Line Tools if needed, clone the repository to `"$HOME"/.dotfiles`,
install Homebrew packages, and create symlinks for all configuration files:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/micahkepe/dotfiles/refs/heads/main/bootstrap.sh)"
```

## Manual Setup

Install Xcode Command Line Tools:

```bash
xcode-select --install
```

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Clone this repository:

```bash
git clone https://github.com/micahkepe/dotfiles ~/.dotfiles
```

Run the bootstrap script:

```bash
cd ~/.dotfiles && ./bootstrap.sh
```

## Other Goodies

- MacOS:
  - [AutoRaise](https://github.com/sbmpost/AutoRaise) &rarr; FollowsFocusMouse
    behavior for MacOS
  - [System Color Picker](https://apps.apple.com/us/app/system-color-picker/id1545870783?mt=12)
    &rarr; color palette utility

---

And that's it! If you have any suggestions or questions feel free to open an
issue or contact me.
