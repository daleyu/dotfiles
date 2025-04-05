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

## Brew packages
Download homebrew first
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Run this to install all brew packages
```
brew install fish jesseduffield/lazygit/lazygit tmux clipboard fzf gcc gh glow neovim node powerlevel10k python ripgrep rust stow tree-sitter wget yazi zoxide go cava graphviz eza ast-grep reattach-to-user-namespace luarocks bat
```
Casks
```
brew install --cask font-hack-nerd-font alt-tab discord firefox obsidian topnotch ghostty google-chrome typora nikitabobko/tap/aerospace
```

## Git
See my git.md in docs.
Remember to include my global path here: 
```
[include]
    path = ~/.config/git/config
```

## Fish 
My terminal of choice for personal computer. 
- My theme is fish tide [equivalent to powerlevel10k]

#### Fisher Plugin Manager
I use fisher instead of omf. I found that omf was more than what I needed, and
that fisher is more widely supported and stable. 
- To download a fisher plugin I would use `fisher install <plugin>`

## ZSH
Terminal used for work. I just use ohmyzsh and then a really minimal setup.
I am not bothered to go beyond that. 


## Zoxide

first `brew install zoxide`
import autojump files with `zoxide import --from=autojump "$HOME/Library/autojump/autojump.txt"`


## Setting up Yazi file manager

Install the packages
```Install packages
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font
```
Download the Catppucin theme
```
ya pack -a yazi-rs/flavors:catppuccin-macchiato
```


## SketchyBar

Install SketchyBar
```bash
brew tap FelixKratz/formulae
brew install sketchybar
brew install borders
```
There are a series of fonts and stuff that need to be downloaded
```
brew install --cask font-hack-nerd-font
```
You also need to download the font from apple. It is called SF symbols and it
can be found here: https://developer.apple.com/sf-symbols/
- You also there are other nerd fonts to explore, but I tried this https://www.nerdfonts.com/
    - There are prob other nerd fonts through brew that are good. 

- Remember to stow the SketchyBar Config
```bash
brew services start sketchybar
brew services restart sketchybar
```
- Start Sketchybar as a background process
    - Sometimes this won't work on a company laptop, even with the same config.
      it must be an issue with the extra security or software on it.

## Setting up Node environment
- NVM as node version manager
`https://github.com/nvm-sh/nvm`

- Fish has to use nvm.fsh

- Installing Bun
    - install using node and just follow the website. I hate JS though.

## Language Setups

### Golang setup

#### USING MULTIPLE VERSIONS OF GO (IMPORTANT)

No point in using goenv or gvm, as they are not the supported technique from the
official go documentation. 
- Instead you should download multiple go versions like https://go.dev/doc/manage-install#installing-multiple,
Then you can set the go version in that terminal session using an alias and also
set the goroot that neovim will use. You also have to export the path in this
session. Then, neovim should be able to recognize the go alias and version. 
> Soon I will export this process to a script that will just be something like
> change_ver go1.18 and then automatically do it.

`$ source gvm <go-version>`
- Use this script to be able to change go version

- if this doesn't work or there are unexpected errors, then it is likely that
the gopls is too updated, you should look at the go docs and get the latest
gopls that works with that version

#### Random Go Packages

Some useful go packages, I've used. 
```
go install github.com/loov/goda@latest
```
- Goda lets you debug gomod and the different dependencies. You will need
graphviz to do some of the commands. 
    - it is kind of buggy but wtv

### Selene and Rust

Setup rust with rustup
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
```
Now we need to get selene. 
```
cargo install selene
```
Make sure you `chmod +x ~/.cargo/bin/selene`

### Javascript

##### Working with Prettier
install prettierd with npm

### Dart and Flutter
TODO

### Java
TODO

### Ruby
TODO

### Python
TODO

### Lua
TODO

### Markdown Preview
- You need to have node.js and yarn installed.
I use nvm to handle all my node stuff so I just curl get nvm from github like
`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash`
and then I install yarn with like `npm install --global yarn`

> Right now Markdown preview has a weird bug where the installation script
> hasn't been working for me without rerunning the install script
This means you should run the command to rerun the install.sh
```
cd /Users/bytedance/.local/share/nvim/lazy/markdown-preview.nvim/app
./install.sh
```

### Setting up VimTex and Zathura
Not gonna bother with this since it isn't needed.
