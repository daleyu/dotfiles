# dotfiles

## Using Stow for dotfile locations

```Installation
brew install stow
// or
sudo apt get stow
```

### Usage
Stow will position the dotfile at the $HOME directory if used by default. Stow
by default sets the file at the parent directory, so you have to specify the
target path.
```Adding a Stow
stow --target="/Users/[username]" tmux
```

How to delete a stow not at base path
```
stow -D --target="/Users/[username]" tmux
```

## Zoxide

first `brew install zoxide`
import autojump files with `zoxide import --from=autojump "$HOME/Library/autojump/autojump.txt"`


## Setting up Yazi file manager

```Install packages
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font
```

## Brew packages
Download homebrew first
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Run this to install all brew packages
```
brew install jesseduffield/lazygit/lazygit tmux clipboard fzf gcc gh glow neovim node powerlevel10k python ripgrep rust stow tree-sitter wget yazi zoxide go 
```
Casks
```
brew install --cask font-hack-nerd-font alt-tab discord firefox obsidian topnotch ghostty google-chrome typora nikitabobko/tap/aerospace
```

## SketchyBar

Install SketchyBar
```bash
brew tap FelixKratz/formulae
brew install sketchybar
```
There are a series of fonts and stuff that need to be downloaded
```
brew install --cask font-hack-nerd-font
```

- Remember to stow the SketchyBar Config
```bash
brew services start sketchybar
brew services restart sketchybar
```
- Start Sketchybar as a background process

