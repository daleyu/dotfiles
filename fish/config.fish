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

#!/bin/fish
# The begin/end block limits the scope of all variables except $PATH
begin
  # This script aims to be a direct mapping of our path.bash.inc shell, rather
  # than idiomatic fish. Why? I don't really understand fish.
  set script_link (readlink (status -f)); or set script_link (status -f)
  # This sed expression is the equivalent of "${script_link%/*}" in bash, which
  # chops off "/*" (with * as a wildcard) from the end of script_link.
  set apparent_sdk_dir (echo $script_link | sed 's/\(.*\)\/.*/\1/')
  if [ "$apparent_sdk_dir" = "$script_link" ]
    set apparent_sdk_dir .
  end
  set old_dir (pwd)
  # No "cd -P" in fish. It always resolves symlinks to their canonical location,
  # though, when you "cd" in.
  # Also, cd is  cd is *both* a shell builtin and shell wrapper function (to
  # implement "cd -") in fish, so "command cd" won't work. "builtin cd" will.
  set sdk_dir (builtin cd "$apparent_sdk_dir" > /dev/null; and pwd)
  builtin cd "$old_dir"
  set bin_path "$sdk_dir/bin"
  # -gx for global (not limited to this begin/end block) and exportable (part of
  # the environment for child processes)
  if not contains "$bin_path" $PATH
    set -gx PATH "$bin_path" $PATH
  end
end

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/daleyu/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/daleyu/Downloads/google-cloud-sdk/path.fish.inc'; end
