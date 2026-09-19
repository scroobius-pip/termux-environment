# Termux Environment

A minimal native-Termux web development environment for Android ARM64.

This repository only configures the coding toolchain. It does **not** configure XFCE, X11, Miracast, ADB, desktop mode, or display routing.

## Installs

- Git
- Node.js LTS + npm
- pnpm
- OpenSSH
- ripgrep
- tmux
- Neovim
- Python
- clang, make, and pkg-config for native Node modules
- curl, wget, and jq
- Codex CLI using the Termux/Android ARM64 community build

## Install

```sh
git clone https://github.com/scroobius-pip/termux-environment.git ~/termux-environment
cd ~/termux-environment
bash setup.sh
```

Then verify the environment:

```sh
dev-doctor
```

Authenticate Codex:

```sh
codex login
```

## Project layout

Keep source code in Termux's own filesystem:

```sh
mkdir -p ~/code
cd ~/code
git clone <repo-url>
cd <repo>
pnpm install
```

Avoid developing directly under `/sdcard` or Android shared storage. It does not behave like a normal Unix filesystem and can break symlinks, permissions, executable bits, and package-manager behavior.

## Daily workflow

From any project directory:

```sh
dev
```

This creates or attaches to a tmux session with three windows:

```text
shell   normal shell
server  dev server
codex   Codex CLI
```

Useful tmux shortcuts:

```text
Ctrl-b n    next window
Ctrl-b p    previous window
Ctrl-b c    new window
Ctrl-b d    detach
```

Run your application in the `server` window, for example:

```sh
pnpm dev
```

## Codex

The standard Codex CLI distribution is not a native Termux target. The setup therefore installs the Android ARM64 community build maintained at [DioNanos/codex-termux](https://github.com/DioNanos/codex-termux):

```sh
npm install -g @mmmbuto/codex-cli-termux@latest
```

To skip Codex during initial setup:

```sh
SKIP_CODEX=1 bash setup.sh
```

To install or reinstall it later:

```sh
bash scripts/install-codex.sh
```

## Common web workflows

Vite / React / vanilla:

```sh
pnpm create vite
pnpm install
pnpm dev
```

Existing Node project:

```sh
pnpm install
pnpm dev
```

Simple static server:

```sh
npx serve .
```

## Notes

- This is native Termux, not Debian or Ubuntu in proot.
- Project-specific native dependencies may require additional Termux packages.
- Packages that assume glibc or ship only conventional Linux binaries may not work on Android/Bionic even when an ARM64 build exists.
- `tmux` keeps dev servers and CLI agents alive independently of a single terminal view.
