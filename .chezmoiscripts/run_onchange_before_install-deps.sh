#!/bin/bash
# Chezmoi script: Install dependencies
# The 'onchange' in filename ensures it only runs when file content changes

set -e

echo "📦 Checking and installing dependencies..."

# Detect OS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "⚠️  Currently only supports macOS"
    exit 0
fi

# Install Homebrew (if not exists)
if ! command -v brew &>/dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dependencies
echo "📦 Installing tools..."

TOOLS=(
    "zoxide"      # Smart directory jumper
    "eza"         # Modern ls
    "atuin"       # History search
    "starship"    # Prompt
    "fzf"         # Fuzzy search
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "git"
    "nvim"
)

for tool in "${TOOLS[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        echo "  Installing $tool..."
        brew install "$tool" 2>/dev/null || echo "  ⚠️ Failed to install $tool or already installed"
    else
        echo "  ✅ $tool already installed"
    fi
done

# Install zinit (if not exists)
if [[ ! -d ~/.local/share/zinit ]]; then
    echo "📦 Installing zinit..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

# Install Nerd Font (if not exists)
if ! fc-list | grep -qi "nerd"; then
    echo "📦 Installing Meslo Nerd Font..."
    brew tap homebrew/cask-fonts 2>/dev/null || true
    brew install --cask font-meslo-lg-nerd-font 2>/dev/null || echo "  ⚠️ Failed to install font, please install manually"
fi

# Install kanata (if not exists)
if ! command -v kanata &>/dev/null; then
    echo "📦 Installing kanata..."
    brew install kanata 2>/dev/null || echo "  ⚠️ Failed to install kanata, please install manually"
else
    echo "  ✅ kanata already installed"
fi

# Check Karabiner Driver (kanata dependency)
if [[ ! -d "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice" ]]; then
    echo "⚠️  Please manually install Karabiner-VirtualHIDDevice-Driver:"
    echo "   brew install --cask karabiner-elements"
fi

echo "✅ Dependency check complete"
