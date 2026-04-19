# dotfiles

Config files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```bash
brew install stow
git clone <repo-url> ~/repos/dotfiles
cd ~/repos/dotfiles
./install.sh
```

## Structure

Each top-level directory is a stow package. Running `stow <pkg>` creates symlinks from `~/` into the repo.

| Package | Files |
|---------|-------|
| `zsh`   | `.zshrc`, `.zprofile`, `.zshenv` |
| `nvim`  | `.config/nvim/init.lua` |
| `tmux`  | `.tmux.conf` |
| `task`  | `.taskrc`, `.taskopenrc` |
| `git`   | `.config/git/ignore` |
| `kitty` | `.config/kitty/kitty.conf` — Shift+Enter extended key sequence for Claude Code |

## Local overrides

Machine-specific config goes in `.local` files (gitignored). Tracked files source them automatically:

- `~/.zshrc.local` — shell aliases, paths, safehouse functions
- `~/.zprofile.local` — login profile paths
- `~/.taskrc.local` — `data.location` and `sync.local.server_dir`
- Set `TASKNOTES_DIR` in `~/.zshrc.local` for taskopen


## External Dependencies
### Nvim
- `tree-sitter-cli`
- `fd`
- `ripgrep`
- `black`

### Tasks
- task
- [taskopen](https://github.com/jschlatow/taskopen)

