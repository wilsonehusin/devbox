#!/usr/bin/env bash

set -euo pipefail

base_url="https://raw.githubusercontent.com/wilsonehusin/devbox/refs/heads/main"

dotfiles=("bashrc" "vimrc")
for f in "${dotfiles[@]}"; do
  curl -o "${HOME}/.${f}" "${base_url}/dot/${f}"
  chown "${USER}:${USER}" "${HOME}/.${f}" 
done

[[ -f "${HOME}/.bash_profile" ]] || cat <<EOF >"${HOME}/.bash_profile"
[[ -s "\$HOME/.bashrc" ]] && source "\$HOME/.bashrc"
EOF

mkdir -p "${HOME}/.config/nvim"
cat <<EOF >"${HOME}.config/nvim/init.vim"
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath=&runtimepath
  source ~/.vimrc
EOF

arch=$(uname -m)
rustarch=""
case "${arch}" in
  "x86_64")
    rustarch="x86_64"
    ;;
  "arm64")
    rustarch="aarch64"
    ;;
  *)
    rustarch="skip"
    ;;
esac

if [[ "${rustarch}" != "skip" ]]; then
  jj_version="0.41.0"
  curl -Lo /tmp/jj.tar.gz "https://github.com/jj-vcs/jj/releases/download/v${jj_version}/jj-v${jj_version}-${rustarch}-unknown-linux-musl.tar.gz"
  tar -zxvf /tmp/jj.tar.gz ./jj
  mkdir -p "${HOME}/.local/bin"
  mv ./jj "${HOME}/.local/bin/"
fi
