# Dotfiles

Cross-machine configuration managed by [Chezmoi](https://www.chezmoi.io/).

## Quick Start

### New Machine Setup

```bash
# 1. Install chezmoi
brew install chezmoi

# 2. Clone and apply configuration
chezmoi init --apply https://github.com/yourusername/dotfiles.git

# Or use SSH
chezmoi init --apply git@github.com:yourusername/dotfiles.git
```

### Local Development (This Repo)

```bash
# Use local source directory
chezmoi init --source <path-to-this-repo>
chezmoi apply
```

## Daily Usage

```bash
# Edit configuration
chezmoi edit ~/.zshrc

# View changes
chezmoi diff

# Apply changes
chezmoi apply

# Add new file to management
chezmoi add ~/.someconfig

# Pull and apply latest configuration
chezmoi update

# View status
chezmoi status
```

## Directory Structure

```
.
├── dot_zshrc.tmpl              # ~/.zshrc
├── dot_gitconfig               # ~/.gitconfig
├── dot_ideavimrc               # ~/.ideavimrc (IntelliJ/Vim)
├── dot_config/
│   ├── zsh/
│   │   ├── aliases.zsh         # Aliases
│   │   ├── tools.zsh           # Tool configurations
│   │   └── local.zsh.example   # Local configuration example
│   ├── starship.toml           # Prompt
│   ├── ghostty/config          # Ghostty terminal
│   ├── kanata/kanata.kbd       # Kanata key remapping
│   └── nvim/                   # LazyVim configuration
├── scripts/
│   ├── run_kanata.sh           # Launch kanata
│   └── leetcode_redirect.user.js
├── .chezmoiscripts/
│   ├── run_onchange_before_install-deps.sh  # Install dependencies
│   ├── run_onchange_after_nvim-setup.sh     # nvim initialization
│   └── run_onchange_after_notify.sh         # Completion notification
└── README.md
```

## Machine-Specific Configuration

Edit `~/.config/zsh/local.zsh` to add machine-specific configurations (not committed to git):

```bash
# Copy example file
cp ~/.config/zsh/local.zsh.example ~/.config/zsh/local.zsh

# Edit to add your configurations
nvim ~/.config/zsh/local.zsh
```

Example content:
```bash
# Custom tools
export PATH="$HOME/.custom-tool/bin:$PATH"
source ~/.customrc 2>/dev/null || true

# Proxy
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

# Machine-specific aliases
alias work='cd ~/work'
alias personal='cd ~/personal'
```

## Included Tools

### Shell Environment
- **zoxide**: Smart directory jumping (`z`)
- **eza**: Modern `ls` replacement
- **atuin**: History search
- **starship**: Minimal prompt
- **fzf**: Fuzzy search
- **zinit**: zsh plugin manager

### Editors
- **nvim**: LazyVim configuration
- **ideavimrc**: IntelliJ IDEA Vim configuration

### Keyboard
- **kanata**: Keyboard remapping tool

## Key Bindings

| Key Binding | Function |
|-------------|----------|
| `z <dir>` | Smart jump to directory |
| `l` / `ll` | Enhanced ls |
| `Ctrl+R` | Atuin history search |
| `..` / `...` | Quick parent directory |

## Kanata Usage

```bash
# Launch kanata (from your dotfiles repo)
<path-to-repo>/scripts/run_kanata.sh

# Configuration file location
~/.config/kanata/kanata.kbd
```

## Nvim Initialization

LazyVim plugins will be automatically downloaded on first run:

```bash
nvim
# Wait for plugin installation to complete
# Press q to exit the startup screen
```
