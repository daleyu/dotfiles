if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export GOPATH="$HOME/go"
path+=("$GOPATH/bin:PATH")

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin:$PATH:$(go env GOPATH)/bin/:~/.utils

export PATH=$HOME/.ripgreprc:$PATH

RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export RIPGREP_CONFIG_PATH

export EDITOR=nvim

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"

plugins=(git
        zsh-syntax-highlighting
        zsh-autosuggestions
		vi-mode
		colored-man-pages
        )

source $ZSH/oh-my-zsh.sh

# Add timestamp to the end of the line
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
RPROMPT="[%D{%m/%f/%y}|%@]"


function git-commit-line() {                                                                                                                       
  git log --oneline --graph --decorate --color=always | \
    fzf --ansi --no-preview --reverse \
    --bind 'j:down,k:up' \
    --bind 'q:abort' \
    --bind 'enter:execute(hash=$(echo {} | grep -o "[a-f0-9]\{7,\}" | head -1); git diff --color=always $hash^..$hash | less -R)'
} 
alias gcl='git-commit-line'
# aliases
alias cat="bat"
alias lg="lazygit"
alias cat="bat"
alias n="nvim"
alias tn="tmux new-session -s"
alias ta="tmux attach-session -t"
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
alias gds='git diff origin/master'
alias gdi='git diff origin/main'

alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"
alias stable-main='git switch main\
	&& git fetch origin/main \
	git reset --hard origin/main
	'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

view-pr() {
    local main_branch
    
    if git rev-parse --verify origin/HEAD >/dev/null 2>&1; then
        main_branch=$(git rev-parse --abbrev-ref origin/HEAD)
    elif git show-ref --verify --quiet refs/heads/main; then
        main_branch="origin/main"
    else
        main_branch="origin/master"
    fi

    local base_hash=$(git merge-base HEAD "$main_branch" 2>/dev/null)

    if [ -n "$base_hash" ]; then
        echo "Found diverging commit from $main_branch: $base_hash"
        git difftool -d "$base_hash" HEAD
    else
      git difftool -d 
      echo "Warn: Could not find a common ancestor between HEAD and $main_branch. So running normal git diff"
    fi
}


source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FPATH="/opt/homebrew/bin/eza/completions/zsh:$FPATH"

# fzf utilities
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude={.git,.idea,Library,.nodenv,.bazel_binaries,.pyenv,.vscode,.sass-cache,node_modules,build,tmp,'bazel-*'} --color=always"
export FZF_DEFAULT_OPTS="--ansi --style full --color=bg+:#8aadf4,gutter:#8aadf4"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--walker-skip .git,node_modules,target,bazel-*
--preview 'bat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_COMMAND="fd --type directory --follow --hidden --exclude={.git,.idea,Library,.nodenv,.bazel_binaries,.pyenv,.vscode,.sass-cache,node_modules,build,tmp,'bazel-*'} --color=always"
export FZF_ALT_C_OPTS="
--walker-skip .git,node_modules,target,bazel-*
--preview 'tree -C {}'"
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

source <(fzf --zsh)

export PATH="$HOME/zig-macos-aarch64-0.15.0-dev.190+bfbf4badd:$PATH"
export PATH=$HOME/.config/tmux/plugins/tmux-session-wizard/bin:$PATH
