# Dotfiles management using Chezmoi

Fedora-targeted dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick start (fresh machine)

```shell
# Install chezmoi and apply everything in one shot
sudo dnf install -y chezmoi
chezmoi init --apply tanguille
```

Chezmoi will automatically run the bootstrap scripts on first apply:

- **`run_once_install-deps.sh`** — installs dnf packages (fish, bat, ripgrep, eza, zoxide, fzf, mise, etc.), Rust toolchain, Fisher + plugins, and cargo tools (nextest, starship, cargo-watch, etc.)
- **`run_once_restore-gnome.sh`** — restores GNOME keybindings and interface preferences

Log out and back in for the shell change to fish to take effect.

## Day-to-day usage

```shell
chezmoi diff      # View differences between repo and local dotfiles
chezmoi apply     # Apply repo changes to local dotfiles
chezmoi add FILE  # Add a local file to the repo
chezmoi update    # Pull latest from remote and apply
```
