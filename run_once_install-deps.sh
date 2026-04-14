#!/bin/bash
# Bootstrap script for a fresh Fedora install
# Run once by chezmoi on first apply
# Prerequisites: chezmoi must already be installed (used to run this script)

set -euo pipefail

echo "==> Installing DNF packages..."
sudo dnf install -y \
    fish \
    mise \
    eza \
    fastfetch \
    micro \
    gh \
    fzf \
    sccache \
    tokei

echo "==> Setting default shell to fish..."
if [ "$SHELL" != "$(which fish)" ]; then
    sudo usermod -s "$(which fish)" "$USER"
fi

echo "==> Installing Rust toolchain..."
if ! command -v rustup &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

echo "==> Installing Fisher and plugins..."
if command -v fish &>/dev/null; then
    fish -c '
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install jorgebucaran/fisher
        fisher install jorgebucaran/autopair.fish
        fisher install nickeb96/puffer-fish
        fisher install patrickf1/fzf.fish
    '
fi

echo "==> Installing cargo tools via binstall..."
if ! command -v cargo-binstall &>/dev/null; then
    cargo install cargo-binstall
fi

cargo binstall -y \
    cargo-autoinherit \
    cargo-bloat \
    cargo-clean-all \
    cargo-expand \
    cargo-features-manager \
    cargo-generate \
    cargo-limit \
    cargo-machete \
    cargo-nextest \
    cargo-udeps \
    cargo-update \
    cargo-watch \
    starship

echo "==> Enabling ssh-agent systemd user service..."
systemctl --user enable --now ssh-agent.socket 2>/dev/null || true

echo "==> Done! Log out and back in for shell change to take effect."
