#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

if [ "$(uname -m)" != "aarch64" ]; then
  echo "Warning: this installer targets Android ARM64 (aarch64)." >&2
fi

command -v node >/dev/null 2>&1 || pkg install -y nodejs-lts

printf '\n==> Installing Codex CLI for Termux\n'
npm install -g @mmmbuto/codex-cli-termux@latest

printf '\n==> Codex version\n'
codex --version
printf '\nRun: codex login\n'
