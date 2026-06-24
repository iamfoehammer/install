# install

Public install scripts for **Equity Hammer** clients.

This repository holds the bootstrap scripts a new client runs to set up a fresh machine
for the Equity Hammer agent stack. Everything here is public and safe to share; it contains
no client data, secrets, or internal tooling, just the one-time setup scripts.

## Layout

- `mac/` - bootstrap script + instructions for a macOS machine (e.g. a Mac mini).
- `wsl/` - bootstrap script + instructions for a Windows machine running Ubuntu under WSL2.

Pick the folder that matches the client's machine and follow its `README.md`.

## What the bootstrap scripts do

Each script gets a bare machine to a known-good starting point:

1. Installs the base tooling (git, Node.js).
2. Installs Claude Code.
3. Creates the standard project workspace (`~/Claude Projects/` with `_archive/` and `_playground/`).
4. Prints the next steps.

The scripts are idempotent - safe to re-run. They never touch secrets and never push anything.
