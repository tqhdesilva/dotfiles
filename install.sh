#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
PACKAGES=(zsh git nvim tmux task kitty pi)
PI_TARGETS=(
    "AGENTS.md"
    ".pi/agent/settings.json"
)

command -v stow >/dev/null || { echo "Install stow first: brew install stow"; exit 1; }

resolve_path() {
    local path="$1"
    local dir base
    dir="$(dirname "$path")"
    base="$(basename "$path")"

    if [ -d "$dir" ]; then
        (cd "$dir" && printf '%s/%s\n' "$(pwd -P)" "$base")
    else
        printf '%s\n' "$path"
    fi
}

link_points_to() {
    local link="$1"
    local expected="$2"
    local link_target resolved expected_resolved

    [ -L "$link" ] || return 1

    link_target="$(readlink "$link")"
    case "$link_target" in
        /*) resolved="$(resolve_path "$link_target")" ;;
        *) resolved="$(resolve_path "$(dirname "$link")/$link_target")" ;;
    esac

    expected_resolved="$(resolve_path "$expected")"
    [ "$resolved" = "$expected_resolved" ]
}

backup_pi_targets() {
    local backup_dir=""
    local rel target source backup_path

    for rel in "${PI_TARGETS[@]}"; do
        target="$HOME/$rel"
        source="$DOTFILES/pi/$rel"

        if link_points_to "$target" "$source"; then
            continue
        fi

        if [ -e "$target" ] || [ -L "$target" ]; then
            if [ -z "$backup_dir" ]; then
                backup_dir="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
            fi

            backup_path="$backup_dir/$rel"
            mkdir -p "$(dirname "$backup_path")"
            mv "$target" "$backup_path"
            echo "Backed up ~/$rel to $backup_path"
        fi
    done
}

git submodule update --init --recursive
backup_pi_targets

for pkg in "${PACKAGES[@]}"; do
    echo "Stowing $pkg..."
    if [ "$pkg" = "pi" ]; then
        stow -v -R --no-folding -t "$HOME" -d "$DOTFILES" "$pkg"
    else
        stow -v -R -t "$HOME" -d "$DOTFILES" "$pkg"
    fi
done

echo ""
echo "Done. Create these .local files:"
echo "  ~/.zshrc.local     : machine-specific shell config"
echo "  ~/.zprofile.local  : machine-specific profile paths"
echo "  ~/.taskrc.local    : data.location and sync paths"
echo "  Set TASKNOTES_DIR in ~/.zshrc.local for taskopen"
