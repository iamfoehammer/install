#!/usr/bin/env bash
#
# Equity Hammer - macOS bootstrap
# Gets a fresh Mac to a known-good starting point for the agent stack.
# Idempotent: safe to re-run. Stores no secrets, pushes nothing.

set -euo pipefail

log()  { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }
ok()   { printf '\033[1;32m  ok\033[0m %s\n' "$1"; }
skip() { printf '\033[1;33m  --\033[0m %s\n' "$1"; }

PROJECTS_DIR="$HOME/Claude Projects"

# 1. Homebrew
if command -v brew >/dev/null 2>&1; then
  skip "Homebrew already installed"
else
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure brew is on PATH for this session (Apple Silicon vs Intel paths differ)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 2. git + Node.js
log "Installing base tooling (git, node)"
for pkg in git node; do
  if brew list "$pkg" >/dev/null 2>&1; then
    skip "$pkg already installed"
  else
    brew install "$pkg"
    ok "$pkg installed"
  fi
done

# 3. Claude Code
if command -v claude >/dev/null 2>&1; then
  skip "Claude Code already installed"
else
  log "Installing Claude Code"
  npm install -g @anthropic-ai/claude-code
  ok "Claude Code installed"
fi

# 4. Standard workspace
log "Creating workspace at: $PROJECTS_DIR"
mkdir -p "$PROJECTS_DIR/_archive" "$PROJECTS_DIR/_playground"
ok "$PROJECTS_DIR ready (with _archive/ and _playground/)"

# 5. Next steps
cat <<'EOF'

Done. Next steps:
  1. Open a new terminal so PATH changes take effect.
  2. Run: claude    (log in when prompted)
  3. Continue with the file-structure and configuration steps in your onboarding guide.

EOF
