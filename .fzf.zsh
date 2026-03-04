# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

source <(fzf --zsh)

export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border right'


