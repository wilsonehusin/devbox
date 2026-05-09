# --- Aliases ---
alias gst="git status"
alias ls="ls --color=auto"

# Use nvim
alias vim="nvim"
export EDITOR=nvim

# --- Tool Initializations ---
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"

# --- Key Bindings ---
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

# --- Configurations ---
# Use bat for manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_CONFIG_PATH="$HOME/.bat.conf"

export KIND_EXPERIMENTAL_PROVIDER=podman

export FZF_DEFAULT_COMMAND="ag --files-with-matches --smart-case --hidden --ignore .git"
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --border"

# Changed from .fzf.zsh to .fzf.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# --- Path Logic ---
if type go &>/dev/null
then
  export PATH="$(go env GOPATH)/bin:${PATH}"
fi
