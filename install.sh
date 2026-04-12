#!/usr/bin/env bash
set -euo pipefail
DOTFILES="$(cd "$(dirname "$0")" && pwd)"
command -v stow >/dev/null || { echo "Install stow first: brew install stow"; exit 1; }
for pkg in zsh git nvim tmux task; do
    echo "Stowing $pkg..."
    stow -v -R -t "$HOME" -d "$DOTFILES" "$pkg"
done
echo ""
echo "Done. Create these .local files:"
echo "  ~/.zshrc.local     — machine-specific shell config"
echo "  ~/.zprofile.local  — machine-specific profile paths"
echo "  ~/.taskrc.local    — data.location and sync paths"
echo "  Set TASKNOTES_DIR in ~/.zshrc.local for taskopen"
