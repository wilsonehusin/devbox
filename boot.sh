#!/usr/bin/env bash

set -euo pipefail

whoami

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
  chown "${user}:${user}" ./jj
  mv ./jj /usr/local/bin/jj

  jj --version
fi
