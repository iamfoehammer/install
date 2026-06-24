#!/usr/bin/env bash
#
# Equity Hammer - WSL (Ubuntu) bootstrap
# Gets a fresh Ubuntu WSL2 distro to a known-good starting point for the agent stack.
# Run from inside the WSL shell. Idempotent: safe to re-run. Stores no secrets, pushes nothing.

set -euo pipefail

log()  { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }
ok()   { printf '\033[1;32m  ok\033[0m %s\n' "$1"; }
skip() { printf '\033[1;33m  --\033[0m %s\n' "$1"; }

PROJECTS_DIR="$HOME/Claude Projects"

# Sanity check: are we actually inside WSL?
if ! grep -qiE "(microsoft|wsl)" /proc/version 2>/dev/null; then
  echo "Warning: this does not look like a WSL environment. Continuing anyway." >&2
fi

# 1. apt base tooling
log "Updating apt and installing base tooling"
sudo apt-get update -y
sudo apt-get install -y git curl build-essential
ok "git, curl, build-essential installed"

# 2. Node.js (via NodeSource) - only if missing
if command -v node >/dev/null 2>&1; then
  skip "Node.js already installed ($(node --version))"
else
  log "Installing Node.js LTS via NodeSource"
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ok "Node.js installed ($(node --version))"
fi

# 3. Claude Code
if command -v claude >/dev/null 2>&1; then
  skip "Claude Code already installed"
else
  log "Installing Claude Code"
  sudo npm install -g @anthropic-ai/claude-code
  ok "Claude Code installed"
fi

# 4. Standard workspace
log "Creating workspace at: $PROJECTS_DIR"
mkdir -p "$PROJECTS_DIR/_archive" "$PROJECTS_DIR/_playground"
ok "$PROJECTS_DIR ready (with _archive/ and _playground/)"

# 5. Next steps
cat <<'EOF'

Done. Next steps:
  1. Open a new WSL shell so PATH changes take effect.
  2. Run: claude    (log in when prompted)
  3. Keep projects in the Linux filesystem (~/...), not under /mnt/c/...
  4. Continue with the file-structure and configuration steps in your onboarding guide.

EOF
