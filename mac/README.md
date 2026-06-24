# macOS bootstrap

Sets up a fresh macOS machine (e.g. a Mac mini) for the Equity Hammer agent stack.

## What it does

1. Installs Homebrew if it is missing.
2. Installs git and Node.js via Homebrew.
3. Installs Claude Code (`@anthropic-ai/claude-code`).
4. Creates the standard workspace at `~/Claude Projects/` with `_archive/` and `_playground/`.
5. Prints the next steps.

The script is idempotent - re-running it skips anything already in place. It does not store
secrets and does not push anything.

## Prereqs

- macOS with administrator access (Homebrew install may prompt for your password).
- An internet connection.

## Run it

Download and review first, then run:

```bash
curl -fsSL https://raw.githubusercontent.com/iamfoehammer/install/main/mac/bootstrap.sh -o bootstrap.sh
less bootstrap.sh        # review before running
bash bootstrap.sh
```

Or, once you trust it, in one line:

```bash
curl -fsSL https://raw.githubusercontent.com/iamfoehammer/install/main/mac/bootstrap.sh | bash
```

## After it finishes

- Open a new terminal so the updated `PATH` takes effect.
- Run `claude` once to log in.
- Continue with the file-structure and configuration steps from your onboarding guide.
