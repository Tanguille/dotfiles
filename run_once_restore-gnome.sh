#!/bin/bash
# Restore GNOME keybindings and safe desktop settings
# Run once by chezmoi on first apply

set -euo pipefail

DCONF_DIR="$HOME/.config/dconf"

if [ ! -d "$DCONF_DIR" ]; then
    echo "==> No dconf backups found, skipping GNOME restore"
    exit 0
fi

echo "==> Restoring GNOME keybindings..."
if [ -f "$DCONF_DIR/gnome-wm-keybindings.dconf" ]; then
    dconf load /org/gnome/desktop/wm/keybindings/ < "$DCONF_DIR/gnome-wm-keybindings.dconf"
fi

echo "==> Restoring GNOME interface preferences..."
if [ -f "$DCONF_DIR/gnome-interface.dconf" ]; then
    dconf load /org/gnome/desktop/interface/ < "$DCONF_DIR/gnome-interface.dconf"
fi

echo "==> GNOME settings restored."
