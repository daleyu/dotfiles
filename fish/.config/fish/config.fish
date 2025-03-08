set -x XDG_CONFIG_HOME "$HOME/.config"
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x PATH $PATH $HOME/.pub-cache/bin
    set -x JAVA_HOME $java_home
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
end

if test -f /opt/homebrew/share/autojump/autojump.fish
    source /opt/homebrew/share/autojump/autojump.fish
end

fish_vi_key_bindings

# Aliases
alias tn="tmux new-session -s"
alias ta="tmux attach-session -t"
alias n="nvim"

alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'

alias lS='eza -1 --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'"


set -Ux PATH $PATH (go env GOPATH)/bin

set -gx EDITOR nvim


function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# first 'brew install fish'
# import autojump files with 'zoxide import --from=autojump "$HOME/Library/autojump/autojump.txt"'
zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

function logo
    echo '                 '(set_color a5b4fd)'___
  ___======____='(set_color f0a9a9)'-'(set_color f5a9e0)'-'(set_color f0a9a9)'-='(set_color a5b4fd)')
/T            \_'(set_color f5a9e0)'--='(set_color f0a9a9)'=='(set_color a5b4fd)')
[ \ '(set_color f0a9a9)'('(set_color f5a9e0)'0'(set_color f0a9a9)')   '(set_color a5b4fd)'\~    \_'(set_color f5a9e0)'-='(set_color f0a9a9)'='(set_color a5b4fd)')
 \      / )J'(set_color f0a9a9)'~~    \\'(set_color f5a9e0)'-='(set_color a5b4fd)')
  \\\\___/  )JJ'(set_color f0a9a9)'~'(set_color f5a9e0)'~~   '(set_color a5b4fd)'\)
   \_____/JJJ'(set_color f0a9a9)'~~'(set_color f5a9e0)'~~    '(set_color a5b4fd)'\\
   '(set_color f0a9a9)'/ '(set_color f5a9e0)'\  '(set_color f5a9e0)', \\'(set_color a5b4fd)'J'(set_color f0a9a9)'~~~'(set_color f5a9e0)'~~     '(set_color f0a9a9)'\\
  (-'(set_color f5a9e0)'\)'(set_color a5b4fd)'\='(set_color f0a9a9)'|'(set_color f5a9e0)'\\\\\\'(set_color f0a9a9)'~~'(set_color f5a9e0)'~~       '(set_color f0a9a9)'L_'(set_color f5a9e0)'_
  '(set_color f0a9a9)'('(set_color a5b4fd)'\\'(set_color f0a9a9)'\\)  ('(set_color f5a9e0)'\\'(set_color f0a9a9)'\\\)'(set_color a5b4fd)'_           '(set_color f5a9e0)'\=='(set_color f0a9a9)'__
   '(set_color a5b4fd)'\V    '(set_color f0a9a9)'\\\\'(set_color a5b4fd)'\) =='(set_color f0a9a9)'=_____   '(set_color f5a9e0)'\\\\\\\\'(set_color f0a9a9)'\\\\
          '(set_color a5b4fd)'\V)     \_) '(set_color f0a9a9)'\\\\'(set_color f5a9e0)'\\\\JJ\\'(set_color f0a9a9)'J\)
                      '(set_color a5b4fd)'/'(set_color f0a9a9)'J'(set_color f5a9e0)'\\'(set_color f0a9a9)'J'(set_color a5b4fd)'T\\'(set_color f0a9a9)'JJJ'(set_color a5b4fd)'J)
                      (J'(set_color f0a9a9)'JJ'(set_color a5b4fd)'| \UUU)
                       (UU)'(set_color normal)
end

logo
function fish_greeting
	echo "
	Welcome Dahlia
	"
end 




