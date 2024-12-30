# Setup fzf
# ---------
if [[ ! "$PATH" == */home/luoyebai/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/luoyebai/.fzf/bin"
fi

source <(fzf --zsh)

export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border right'


