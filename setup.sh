#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

printf '\n==> Updating Termux packages\n'
pkg update
pkg upgrade -y

printf '\n==> Installing web-development toolchain\n'
pkg install -y \
  git \
  nodejs-lts \
  openssh \
  ripgrep \
  tmux \
  neovim \
  python \
  clang \
  make \
  pkg-config \
  curl \
  wget \
  jq

printf '\n==> Installing pnpm\n'
npm install -g pnpm@latest

if [ "${SKIP_CODEX:-0}" != "1" ]; then
  "$(dirname "$0")/scripts/install-codex.sh"
else
  printf '\n==> Skipping Codex (SKIP_CODEX=1)\n'
fi

PREFIX_BIN="${PREFIX:-/data/data/com.termux/files/usr}/bin"
printf '\n==> Installing helper commands into %s\n' "$PREFIX_BIN"
for f in "$(dirname "$0")"/bin/*; do
  install -m 755 "$f" "$PREFIX_BIN/$(basename "$f")"
done

mkdir -p "$HOME/code"

printf '\nDone.\n\n'
printf '  dev-doctor   verify the environment\n'
printf '  dev          open/attach the project tmux workspace\n'
printf '  codex login  authenticate Codex\n\n'
