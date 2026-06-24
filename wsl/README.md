# WSL (Ubuntu) bootstrap

Sets up a fresh Ubuntu WSL2 distro on a Windows machine for the Equity Hammer agent stack.

## What it does

1. Updates apt and installs base tooling (git, curl, build-essential).
2. Installs Node.js (via NodeSource).
3. Installs Claude Code (`@anthropic-ai/claude-code`).
4. Creates the standard workspace at `~/Claude Projects/` with `_archive/` and `_playground/`.
5. Prints the next steps.

The script is idempotent - re-running it skips anything already in place. It does not store
secrets and does not push anything.

## Prereqs

- Windows with WSL2 installed and an Ubuntu distro (`wsl --install -d Ubuntu`).
- Run this from **inside the WSL shell**, not from Windows PowerShell or Explorer.
- An internet connection. Some steps use `sudo` and may prompt for your password.

## Run it

Open the Ubuntu shell, then download and review first:

```bash
curl -fsSL https://raw.githubusercontent.com/iamfoehammer/install/main/wsl/bootstrap.sh -o bootstrap.sh
less bootstrap.sh        # review before running
bash bootstrap.sh
```

Or, once you trust it, in one line:

```bash
curl -fsSL https://raw.githubusercontent.com/iamfoehammer/install/main/wsl/bootstrap.sh | bash
```

## After it finishes

- Open a new WSL shell so the updated `PATH` takes effect.
- Run `claude` once to log in.
- Keep your projects in the Linux filesystem (`~/...`), not under `/mnt/c/...` (the Windows
  drive is slow over the WSL bridge and breaks file watchers).
- Continue with the file-structure and configuration steps from your onboarding guide.
