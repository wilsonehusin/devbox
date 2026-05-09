#!/usr/bin/env bash

set -euo pipefail

user=${CODER_USER:-dev}
base_url="https://raw.githubusercontent.com/wilsonehusin/devbox/refs/heads/main"

dotfiles=("bashrc" "vimrc")
for f in "${dotfiles[@]}"; do
  curl -o "/home/${user}/.${f}" "${base_url}/dot/${f}"
  chown "${user}:${user}" "/home/${user}/.${f}" 
done

[[ -f "/home/${user}/.bash_profile" ]] || cat <<EOF >"/home/${user}/.bash_profile"
[[ -s "\$HOME/.bashrc" ]] && source "\$HOME/.bashrc"
EOF
