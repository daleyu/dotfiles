set -x XDG_CONFIG_HOME "$HOME/.config"
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x PATH $PATH $HOME/.pub-cache/bin
    set -x JAVA_HOME $java_home
end

if test -f /opt/homebrew/share/autojump/autojump.fish
    source /opt/homebrew/share/autojump/autojump.fish
end

fish_vi_key_bindings
alias tn="tmux new-session -s"
alias ta="tmux attach-session -t"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/daleyu/anaconda3/bin/conda
    eval /Users/daleyu/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

#status --is-interactive; and ~/.rbenv/bin/rbenv init - fish | source
if command -v rbenv > /dev/null
    eval (rbenv init - | source)
end

set -Ux PATH $PATH (go env GOPATH)/bin

